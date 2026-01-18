extends Node2D

@onready var wallTileMapLayer = $WallTileMapLayer
@onready var roofTileMapLayer = $RoofTileMapLayer
var door_cell: Vector2i

var inside_house: bool = false:
	set(value):
		inside_house = value
		if inside_house:
			wallTileMapLayer.set_cell(door_cell, 0, Vector2i(1, 1))
			roofTileMapLayer.hide()
		else:
			wallTileMapLayer.set_cell(door_cell, 0, Vector2i(0, 4))
			roofTileMapLayer.show()

func _ready() -> void:
	for cell in wallTileMapLayer.get_used_cells():
		if wallTileMapLayer.get_cell_tile_data(cell).get_custom_data("door") as bool:
			door_cell = cell
			break
	print("door cell: ", door_cell)


func _on_house_area_2d_body_entered(_body: Node2D) -> void:
	inside_house = true
	# print("body entered house: ", body.name)


func _on_house_area_2d_body_exited(_body: Node2D) -> void:
	inside_house = false
	# print("body exited house", body.name)
