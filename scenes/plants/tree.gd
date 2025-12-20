extends StaticBody2D

const apple_texture = preload("res://assets/plants/apple.png")

var health := 3:
	set(value):
		if value <= 0:
			health = 0
			$Apples.queue_free()
			$FlashSprite2D.hide()
			$Sprite2D.show()
			var capsule_shape = CapsuleShape2D.new()
			capsule_shape.radius = 6
			capsule_shape.height = 12
			$CollisionShape2D.shape = capsule_shape
			$CollisionShape2D.position.y = -6
		else:
			health = value

func _ready() -> void:
	add_to_group("objects")
	create_apples(randi_range(1, 5))

func hit(bi: int):
	if bi == 0 && health > 0:
		health -= 1
		$FlashSprite2D.flash()
		var apples = $Apples.get_children()
		if apples.size() > 0:
			apples.pick_random().queue_free()

func create_apples(num: int):
	var apple_positions = $ApplePositons.get_children()
	for i in num:
		var ap = apple_positions.pop_at(randi_range(0, apple_positions.size() - 1))
		var sprite2d = Sprite2D.new()
		sprite2d.texture = apple_texture
		$Apples.add_child(sprite2d)
		sprite2d.position = ap.position
