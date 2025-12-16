extends Node


func _ready() -> void:
	InputMapUtil.add_actions({
		"left": KEY_A,
		"right": KEY_D,
		"up": KEY_W,
	   	"down": KEY_S
	})
