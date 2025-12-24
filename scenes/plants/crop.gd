@tool
class_name CropPlant extends StaticBody2D

@export var plant_resource: PlantResource

func _ready() -> void:
	add_to_group("plants")
	if plant_resource:
		$FlashSprite2D.texture = plant_resource.texture

func initialize(grid: Vector2i, si: int, plants: Node2D) -> Node2D:
	match si:
		0:
			plant_resource = CronPlantResource.new()
		1:
			plant_resource = PumpkinPlantResource.new()
		2:
			plant_resource = TomatoPlantResource.new()
		3:
			plant_resource = WheatPlantResource.new()
	$FlashSprite2D.texture = plant_resource.texture
	plant_resource.grid_position = grid
	position = grid * DATA.TILE_SIZE + Vector2i(8, 12)
	plants.add_child(self)
	return self


func grow(has_water: bool) -> void:
	if has_water:
		plant_resource.grow($FlashSprite2D)
	else:
		plant_resource.wither(self)


func _on_area_2d_body_entered(body: Node2D) -> void:
	if plant_resource.mature() && body.is_in_group("player"):
		$FlashSprite2D.flash(0.2, 0.2, Callable(self, "queue_free"))