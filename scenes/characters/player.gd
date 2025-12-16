extends CharacterBody2D


var direction: Vector2
var speed := 60


func _physics_process(_delta: float) -> void:
	direction = Input.get_vector("left", "right", "up", "down")
	if direction:
		$Animation/AnimationTree.set("parameters/RunBlendSpace2D/blend_position", direction)
	else:
		$Animation/AnimationTree.set("parameters/RunBlendSpace2D/blend_position", Vector2.ZERO)
	velocity = direction * speed
	move_and_slide()
