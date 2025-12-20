extends Control

var texture_scene = preload("res://scenes/UI/UITextureRect.tscn")
@onready var container = $Container

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	container.hide()
	for i in DATA.TEXTURES:
		var texture_rect = texture_scene.instantiate()
		texture_rect.setup(i)
		container.add_child(texture_rect)

func show_tool_ui(behavior_index: int) -> void:
	container.show()
	$Timer.start()
	var tool_textures = container.get_children()
	for i in tool_textures.size():
		if i == behavior_index:
			tool_textures[i].scale(true)
		else:
			tool_textures[i].scale(false)


func _on_timer_timeout() -> void:
	container.hide()
