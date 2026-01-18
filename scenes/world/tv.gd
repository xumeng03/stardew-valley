extends StaticBody2D


func interact(_player: Node2D) -> void:
	$AnimatedSprite2D.play("rainy" if DATA.weather else "sunny")
