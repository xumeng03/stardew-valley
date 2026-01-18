extends CharacterBody2D


var direction: Vector2
var last_direction := Vector2.ZERO
var switch_direction: int
@export var speed := 60
var behavior_index := 0
var seed_index := 0
var can_move := true
@onready var animation_tree = $Animation/AnimationTree
@onready var move_state_machine: AnimationNodeStateMachinePlayback = animation_tree.get("parameters/MoveStateMachine/playback")
@onready var behavior_state_machine: AnimationNodeStateMachinePlayback = animation_tree.get("parameters/BehaviorStateMachine/playback")

signal behavior_signal(bi: int, si: int, pos: Vector2)
signal move_signal(pos: Vector2)

func _ready() -> void:
	add_to_group("player")

func _physics_process(_delta: float) -> void:
	if can_move:
		# process direction,behavior switch action information
		process_input()
		# use direction reset move_state_machine
		process_move_state_machine()
		# use behavior reset behavior_state_machine
		process_behavior_state_machine()
		# process action action information
		process_behavior()
		# character movement
		process_move()
	else:
		process_fish_behavior()
	move_signal.emit(position + last_direction * 16 + Vector2(0, 2))

func process_input():
	direction = Input.get_vector(DATA.ACTIONS_LEFT, DATA.ACTIONS_RIGHT, DATA.ACTIONS_UP, DATA.ACTIONS_DOWN)

	if Input.is_action_just_pressed(DATA.ACTIONS_BEHAVIOR_SWITCH_PREVIOUS) or Input.is_action_just_pressed(DATA.ACTIONS_BEHAVIOR_SWITCH_NEXT):
		switch_direction = sign(Input.get_axis(DATA.ACTIONS_BEHAVIOR_SWITCH_PREVIOUS, DATA.ACTIONS_BEHAVIOR_SWITCH_NEXT))
		behavior_index = posmod(behavior_index + switch_direction, DATA.ANIMATIONS.size())
		# print(switch_direction," ", behavior_index)
		$ToolUI.show_tool_ui(behavior_index)
	if Input.is_action_just_pressed(DATA.ACTIONS_SEED_SWITCH_NEXT):
		if behavior_index == 5:
			seed_index = posmod(seed_index + 1, DATA.SEED_TEXTURES.size())
			$SeedUI.show_seed_ui(seed_index)


func process_move_state_machine():
	if direction:
		last_direction = direction
		move_state_machine.travel("RunBlendSpace2D")
		animation_tree.set("parameters/MoveStateMachine/RunBlendSpace2D/blend_position", direction)
		animation_tree.set("parameters/MoveStateMachine/IdleBlendSpace2D/blend_position", direction)
		animation_tree.set("parameters/FishBlendSpace2D/blend_position", direction)
		for animation in DATA.ANIMATIONS:
			animation_tree.set("parameters/BehaviorStateMachine/" + animation.capitalize() + "BlendSpace2D/blend_position", direction)
	else:
		move_state_machine.travel("IdleBlendSpace2D")

func process_behavior_state_machine():
	var behavior_name = DATA.ANIMATIONS[behavior_index].capitalize()
	behavior_state_machine.travel(behavior_name + "BlendSpace2D")

func process_behavior():
	if Input.is_action_just_pressed(DATA.ACTIONS_ACTION):
		if $RayCast2D.is_colliding():
			# print("colliding", $RayCast2D.get_collider().name)
			$RayCast2D.get_collider().interact(self)
		else:
			animation_tree.set("parameters/OneShot/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)

func process_fish_behavior():
	if Input.is_action_just_pressed(DATA.ACTIONS_ACTION):
		print("process fish behavior")

func process_move():
	velocity = direction * speed
	if direction:
		var ray_direction = Vector2(direction.x, 0) if direction.x != 0 else Vector2(0, direction.y)
		$RayCast2D.target_position = ray_direction.normalized() * 20
	move_and_slide()

func start_fishing():
	print("start fishing")
	animation_tree.set("parameters/FishBlend2/blend_amount", 1)

func _on_animation_tree_animation_started(_anim_name: StringName) -> void:
	can_move = false


func _on_animation_tree_animation_finished(_anim_name: StringName) -> void:
	can_move = true

func _on_behavior():
	# print(DATA.ANIMATIONS[behavior_index].capitalize())
	behavior_signal.emit(behavior_index, seed_index, position + last_direction * 16 + Vector2(0, 2))
