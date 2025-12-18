extends Node2D

var previous_highlight_tile: Vector2i = Vector2i(-999, -999)

func _on_player_behavior_signal(bi: int, pos: Vector2) -> void:
	var grid: Vector2i = Vector2i(floor(pos.x / DATA.TILE_SIZE), floor(pos.y / DATA.TILE_SIZE))
	if bi == 1:
		var tile_data = $Farm/GressTileMapLayer.get_cell_tile_data(grid) as TileData
		if tile_data and tile_data.get_custom_data("farm_able") as bool:
			$Farm/SoilTileMapLayer.set_cells_terrain_connect([grid], 0, 0)
	if bi == 3:
		var tile_data = $Farm/SoilTileMapLayer.get_cell_tile_data(grid) as TileData
		if tile_data:
			$Farm/SoilWaterTileMapLayer.set_cell(grid, 0, Vector2i(randi_range(0, 2), 0), 0)


func _on_player_move_signal(pos: Vector2) -> void:
	var grid: Vector2i = Vector2i(floor(pos.x / DATA.TILE_SIZE), floor(pos.y / DATA.TILE_SIZE))

	if previous_highlight_tile != Vector2i(-999, -999):
		$Farm/HighLightTileMapLayer.erase_cell(previous_highlight_tile)

	# use source_id=0, atlas_coords=Vector2i(1, 1) to highlight the tile
	$Farm/HighLightTileMapLayer.set_cell(grid, 0, Vector2i(1, 1), 0)

	previous_highlight_tile = grid