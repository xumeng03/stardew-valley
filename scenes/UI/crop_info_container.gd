extends Control

func add_crop_info(crop_info: Control) -> void:
	$MarginContainer/ScrollContainer/VBoxContainer.add_child(crop_info)

func update_crop_info() -> void:
	var crop_infos = $MarginContainer/ScrollContainer/VBoxContainer.get_children()
	for crop_info in crop_infos:
		crop_info.update()