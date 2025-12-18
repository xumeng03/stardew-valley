extends Node2D

var previous_highlight_tile: Vector2i = Vector2i(-999, -999)

func _on_player_behavior_signal(bi: int, pos: Vector2) -> void:
	var grid: Vector2i = Vector2i(floor(pos.x / DATA.TILE_SIZE), floor(pos.y / DATA.TILE_SIZE))
	if bi == 1:
		$Farm/SoilTileMapLayer.set_cells_terrain_connect([grid], 0, 0)


func _on_player_move_signal(pos: Vector2) -> void:
	var grid: Vector2i = Vector2i(floor(pos.x / DATA.TILE_SIZE), floor(pos.y / DATA.TILE_SIZE))

	if previous_highlight_tile != Vector2i(-999, -999):
		$Farm/HighLightTileMapLayer.erase_cell(previous_highlight_tile)

	# use source_id=0, atlas_coords=Vector2i(1, 1) to highlight the tile
	$Farm/HighLightTileMapLayer.set_cell(grid, 0, Vector2i(1, 1), 0)

	previous_highlight_tile = grid