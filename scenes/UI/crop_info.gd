extends Control


var plant_resource: PlantResource

func initialize(pr: PlantResource):
	plant_resource = pr
	$PanelContainer/HBoxContainer/TextureRect.texture = pr.icon
	$PanelContainer/HBoxContainer/VBoxContainer/Label.text = pr.name
	update()
	plant_resource.changed.connect(dead)

func update():
	$PanelContainer/HBoxContainer/VBoxContainer/GrowTextureProgressBar.max_value = plant_resource.hframes
	$PanelContainer/HBoxContainer/VBoxContainer/GrowTextureProgressBar.value = plant_resource.age

	$PanelContainer/HBoxContainer/VBoxContainer/HealthTextureProgressBar.max_value = plant_resource.health
	$PanelContainer/HBoxContainer/VBoxContainer/HealthTextureProgressBar.value = plant_resource.health

func dead():
	var tween = create_tween()
	tween.tween_interval(0.5)
	tween.tween_callback(queue_free)
