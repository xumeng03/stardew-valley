@abstract
class_name PlantResource extends Resource

@export var texture: Texture2D
var grid_position: Vector2i
var age: int = 0
var health: int = 3

func grow(sprite: Sprite2D) -> void:
	age += 1
	sprite.frame = min(age, sprite.hframes - 1)
	health = 3

func wither(crop: CropPlant):
	health -= 1
	if health <= 0:
		crop.queue_free()