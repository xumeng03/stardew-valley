extends Node2D

@onready var day_duration: float = $Timer.wait_time
@export var dawn_start: float = 0.25
@export var dawn_duration: float = 1.0/24.0
@export var dusk_start: float = 0.75
@export var dusk_duration: float = 1.0/24.0

var dawn_color := Color(1.0, 0.8, 0.6, 1.0) # 黎明：温暖的橙色
var day_color := Color(1.0, 1.0, 1.0, 1.0) # 白天：白色（正常）
var dusk_color := Color(0.8, 0.6, 0.7, 1.0) # 黄昏：偏红的暗色
var night_color := Color(0.3, 0.3, 0.5, 1.0) # 夜晚：偏蓝的暗色

var current_time: float = 0.0

func _ready() -> void:
	current_time = day_duration * dawn_start

func _physics_process(delta: float) -> void:
	current_time += delta
	if current_time >= day_duration:
		current_time = 0.0
	var color: Color
	print(round(current_time))
	if current_time >= day_duration * dawn_start and current_time < day_duration * dawn_start + day_duration * dawn_duration:
		# 黎明时间
		color = dawn_color

	elif current_time > day_duration * dawn_start + day_duration * dawn_duration and current_time < day_duration * dusk_start:
		# 白天时间
		color = day_color
	elif current_time >= day_duration * dusk_start and current_time < day_duration * dusk_start + day_duration * dusk_duration:
		# 黄昏时间
		color = dusk_color
	else:
		# 夜晚时间
		color = night_color
	$CanvasModulate.color = color
