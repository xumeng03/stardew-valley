extends Node2D

@onready var timer := $Timer
@onready var day_duration: float = timer.wait_time
@onready var player = get_tree().get_first_node_in_group("player")
@export_range(0, 1) var dawn_start: float = 0.25
@export_range(0, 1) var dawn_duration: float = 1.0 / 24.0
@export_range(0, 1) var dusk_start: float = 0.75
@export_range(0, 1) var dusk_duration: float = 1.0 / 24.0

var dawn_color := Color(1.0, 0.8, 0.6, 1.0)
var day_color := Color(1.0, 1.0, 1.0, 1.0)
var dusk_color := Color(0.8, 0.6, 0.7, 1.0)
var night_color := Color(0.3, 0.3, 0.5, 1.0)

func _ready() -> void:
	timer.start(day_duration * (1 - dawn_start))

func _physics_process(_delta: float) -> void:
	if timer.time_left < 0:
		return

	var time_right: float = day_duration - timer.time_left

	var color: Color
	print(round(time_right))
	if time_right >= day_duration * dawn_start and time_right < day_duration * dawn_start + day_duration * dawn_duration:
		color = dawn_color
	elif time_right >= day_duration * dawn_start + day_duration * dawn_duration and time_right < day_duration * dusk_start:
		color = day_color
	elif time_right >= day_duration * dusk_start and time_right < day_duration * dusk_start + day_duration * dusk_duration:
		color = dusk_color
	else:
		color = night_color
	$CanvasModulate.color = color


func _on_timer_timeout() -> void:
	var tween := create_tween()
	tween.tween_property((player.get_node("ColorRect") as ColorRect).material, "shader_parameter/progress", 0.0, 1)
	tween.tween_interval(15)
	tween.tween_callback(func(): timer.start(day_duration * (1 - dawn_start)))
	tween.tween_property((player.get_node("ColorRect") as ColorRect).material, "shader_parameter/progress", 1.0, 1)
