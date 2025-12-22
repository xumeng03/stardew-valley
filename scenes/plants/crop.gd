@tool
class_name CropPlant extends StaticBody2D

@export var plant_resource: PlantResource

func _ready() -> void:
	add_to_group("plants")
	if plant_resource:
		$Sprite2D.texture = plant_resource.texture

func initialize(grid: Vector2i, plants: Node2D) -> Node2D:
	plant_resource.grid_position = grid
	position = grid * DATA.TILE_SIZE + Vector2i(8, 12)
	plants.add_child(self)
	return self


func grow(has_water: bool) -> void:
	if has_water:
		plant_resource.grow($Sprite2D)
