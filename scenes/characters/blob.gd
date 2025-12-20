extends CharacterBody2D

@export var speed := 20
@export var push_distance := 200
@onready var player = get_tree().get_first_node_in_group("player")
var push_direction := Vector2.ZERO
var health := 3:
	set(value):
		health = value
		if health <= 0:
			speed = 0
			$AnimationPlayer.play("die")

func _ready() -> void:
	add_to_group("objects")

func _physics_process(_delta: float) -> void:
	var direction = (player.position - position).normalized()
	velocity = direction * speed + push_direction
	move_and_slide()

func push() -> void:
	var target = (player.position - position).normalized() * -1 * push_distance
	var tween = create_tween()
	tween.tween_property(self, "push_direction", target, 0.1)
	tween.tween_property(self, "push_direction", Vector2.ZERO, 0.1)

func hit(bi: int) -> void:
	if bi == 2 && health > 0:
		health -= 1
		$FlashSprite2D.flash()
		push()
