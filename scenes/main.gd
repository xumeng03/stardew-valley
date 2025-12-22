extends Node2D

@onready var Plants = $Objects/Plants
var crop_scene = preload("res://scenes/plants/crop.tscn")
var previous_highlight_tile: Vector2i = Vector2i(-999, -999)
var plants: Array[Node2D] = []

func cell_has_plant(grid: Vector2i) -> bool:
	for plant in plants:
		if plant.position.x == grid.x and plant.position.y == grid.y:
			return true
	return false

func _on_player_behavior_signal(bi: int, pos: Vector2) -> void:
	var grid: Vector2i = Vector2i(floor(pos.x / DATA.TILE_SIZE), floor(pos.y / DATA.TILE_SIZE))
	if bi == 0:
		for o in get_tree().get_nodes_in_group("objects"):
			o = o as Node2D
			if o.position.distance_to(pos) < DATA.TILE_SIZE:
				o.hit(bi)
	if bi == 1:
		var tile_data = $Farm/GressTileMapLayer.get_cell_tile_data(grid) as TileData
		if tile_data and tile_data.get_custom_data("farm_able") as bool:
			$Farm/SoilTileMapLayer.set_cells_terrain_connect([grid], 0, 0)
	if bi == 2:
		for o in get_tree().get_nodes_in_group("objects"):
			o = o as Node2D
			if o.position.distance_to(pos) < DATA.TILE_SIZE:
				o.hit(bi)
	if bi == 3:
		var tile_data = $Farm/SoilTileMapLayer.get_cell_tile_data(grid) as TileData
		if tile_data:
			$Farm/SoilWaterTileMapLayer.set_cell(grid, 0, Vector2i(randi_range(0, 2), 0), 0)
	if bi == 4:
		var gress_tile_data = $Farm/GressTileMapLayer.get_cell_tile_data(grid) as TileData
		var soil_tile_data = $Farm/SoilTileMapLayer.get_cell_tile_data(grid) as TileData
		if not gress_tile_data and not soil_tile_data:
			print("can fish here")
		else:
			print("can't fish here")
	if bi == 5:
		var tile_data = $Farm/SoilTileMapLayer.get_cell_tile_data(grid) as TileData
		var plant_position = grid * DATA.TILE_SIZE + Vector2i(8, 12)
		if tile_data and not cell_has_plant(plant_position):
			var crop = crop_scene.instantiate()
			crop.initialize(grid, Plants)
			plants.append(crop)

func _on_player_move_signal(pos: Vector2) -> void:
	var grid: Vector2i = Vector2i(floor(pos.x / DATA.TILE_SIZE), floor(pos.y / DATA.TILE_SIZE))

	if previous_highlight_tile != Vector2i(-999, -999):
		$Farm/HighLightTileMapLayer.erase_cell(previous_highlight_tile)

	# use source_id=0, atlas_coords=Vector2i(1, 1) to highlight the tile
	$Farm/HighLightTileMapLayer.set_cell(grid, 0, Vector2i(1, 1), 0)

	previous_highlight_tile = grid
