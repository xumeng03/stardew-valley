extends Node2D

var progress := 20.0
var fish_speed := 20.0
var bar_speed := 20.0
var bar_rect: Rect2
@onready var timer: Timer = $Timer


func start_fish_game() -> void:
	show()
	bar_rect = $BarSprite2D.get_rect()
	var initial_position = Vector2(-3, randi_range(-43, 43))
	$FishSprite2D.position = initial_position
	$BarSprite2D.position = initial_position
	timer.one_shot = false
	timer.wait_time = 1.0
	if not timer.timeout.is_connected(_on_timer_timeout):
		timer.timeout.connect(_on_timer_timeout)
	timer.start()
	progress = 20.0

func _on_timer_timeout() -> void:
	fish_speed = randf_range(-20.0, 20.0)

func _process(delta: float) -> void:
	if visible:
		var new_fish_position = $FishSprite2D.position.y + fish_speed * delta
		$FishSprite2D.position.y = clamp(new_fish_position, -43, 43)
		bar_speed = bar_speed + 20.0 * delta
		var new_bar_position = $BarSprite2D.position.y + bar_speed * delta
		$BarSprite2D.position.y = clamp(new_bar_position, -37, 37)

		var top = $BarSprite2D.position.y - bar_rect.size.y / 2
		var bottom = $BarSprite2D.position.y + bar_rect.size.y / 2
		if $FishSprite2D.position.y > top and $FishSprite2D.position.y < bottom:
			# print("fish is in the bar")
			progress += 15 * delta
		else:
			# print("fish is not in the bar")
			progress -= 15 * delta
		$Control/TextureProgressBar.value = progress


func action() -> void:
	bar_speed = -30.0

func _on_texture_progress_bar_value_changed(value: float) -> void:
	if value >= 100.0:
		print("fish is captured")
	elif value <= 0.0:
		print("fish is escaped")
	else:
		return
	timer.stop()
	hide()
	get_parent().stop_fishing()
