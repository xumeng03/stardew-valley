extends Node2D

@export var day_duration: float = 240.0
@onready var timer := $Timer
@onready var player = get_tree().get_first_node_in_group("player")
@export_range(0, 1) var dawn_start: float = 0.25
@export_range(0, 1) var dawn_duration: float = 1.0 / 24.0
@export_range(0, 1) var dusk_start: float = 0.75
@export_range(0, 1) var dusk_duration: float = 1.0 / 24.0
@export var rain_color: Color = Color(0.3, 0.3, 0.5, 1.0)
@export var raining: bool = false:
	set(value):
		raining = value
		$RippleGPUParticles2D.emitting = raining
		$RainDropGPUParticles2D.emitting = raining
var dawn_color := Color(1.0, 0.8, 0.6, 1.0)
var day_color := Color(1.0, 1.0, 1.0, 1.0)
var dusk_color := Color(0.8, 0.6, 0.7, 1.0)
var night_color := Color(0.3, 0.3, 0.5, 1.0)

var is_transitioning: bool = false

func _ready() -> void:
	raining = DATA.weather
	DATA.weather = [true, false].pick_random()
	print("Tomorrow will be rainy" if DATA.weather else "Tomorrow will be sunny")
	timer.wait_time = day_duration
	timer.start(day_duration * (1 - dawn_start))

func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed(DATA.ACTIONS_NEXT_DAY):
		_on_timer_timeout()

	if is_transitioning:
		return

	if timer.time_left < 0:
		return

	var time_right: float = day_duration - timer.time_left

	var color: Color
	# print(round(time_right))
	if time_right >= day_duration * dawn_start and time_right < day_duration * dawn_start + day_duration * dawn_duration:
		color = dawn_color
	elif time_right >= day_duration * dawn_start + day_duration * dawn_duration and time_right < day_duration * dusk_start:
		color = day_color
	elif time_right >= day_duration * dusk_start and time_right < day_duration * dusk_start + day_duration * dusk_duration:
		color = dusk_color
	else:
		color = night_color
	$CanvasModulate.color = color.lerp(rain_color, 0.5 if raining else 0.0)


func _on_timer_timeout() -> void:
	timer.stop()
	is_transitioning = true
	var shader_material = player.get_node("ColorRect").material as ShaderMaterial
	var tween := create_tween()
	tween.tween_property(shader_material, "shader_parameter/progress", 0.0, 1)
	tween.tween_interval(1)
	tween.tween_callback(func():
		var plants = get_tree().get_nodes_in_group("plants")
		for plant in plants:
			plant.grow(plant.plant_resource.grid_position in get_parent().get_node("Farm/SoilWaterTileMapLayer").get_used_cells())
		var farm = get_parent().get_node("Farm")
		farm.get_node("SoilWaterTileMapLayer").clear()
		get_parent().get_node("CanvasLayer/CropContainer").update_crop_info()
		raining = DATA.weather
		DATA.weather = [true, false].pick_random()
		print("Tomorrow will be rainy" if DATA.weather else "Tomorrow will be sunny")
		if raining:
			var soilTileMapLayer = get_parent().get_node("Farm/SoilTileMapLayer")
			var soilWaterTileMapLayer = get_parent().get_node("Farm/SoilWaterTileMapLayer")
			for cell in soilTileMapLayer.get_used_cells():
				soilWaterTileMapLayer.set_cell(cell, 0, Vector2i(randi_range(0, 2), 0), 0)
		$CanvasModulate.color = dawn_color.lerp(rain_color, 0.5 if raining else 0.0)
	)
	tween.tween_property(shader_material, "shader_parameter/progress", 1.0, 1)
	tween.tween_callback(func():
		timer.start(day_duration * (1 - dawn_start))
		is_transitioning = false
	)
