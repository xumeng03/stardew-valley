extends Control


func setup(texture: Texture2D) -> void:
	$TextureRect.texture = texture


func scale(flag: bool) -> void:
	var tween = create_tween()
	if flag:
		tween.tween_property($TextureRect, "custom_minimum_size", Vector2(20, 20), 0.01)
	else:
		tween.tween_property($TextureRect, "custom_minimum_size", Vector2(16, 16), 0.01)
