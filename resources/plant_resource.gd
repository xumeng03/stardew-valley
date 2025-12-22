@abstract
class_name PlantResource extends Resource

@export var texture: Texture2D
var grid_position: Vector2i
var age: int = 0

func grow(sprite: Sprite2D) -> void:
	age += 1
	sprite.frame = min(age, sprite.hframes - 1)
