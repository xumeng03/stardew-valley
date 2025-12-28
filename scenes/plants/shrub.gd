@tool
extends StaticBody2D

@export var random := true
@export var coord: Vector2i = Vector2i(0, 0):
	set(value):
		coord = value
		$Sprite2D.frame_coords = coord
@export_tool_button("Randomize") var randomize_coord := randomize

func _ready() -> void:
	if random:
		coord = Vector2i(randi_range(0, 3), randi_range(0, 1))
	$Sprite2D.frame_coords = coord
	if coord.x < 1:
		$CollisionShape2D.disabled = true
		z_index = -1

func randomize() -> void:
		coord = Vector2i(randi_range(0, 3), randi_range(0, 1))
