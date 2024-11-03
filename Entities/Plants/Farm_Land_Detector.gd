extends Area2D

var current_tilemaplayer: TileMapLayer
var current_RID: RID
var tile_data: TileData
var tile_coords: Vector2i

func _process_tilemap_collision(body: Node2D, body_rid:RID):
	current_tilemaplayer = body
	current_RID = body_rid
	#print("entered " + body.to_string())
	
	tile_coords = current_tilemaplayer.get_coords_for_body_rid(body_rid)
	tile_data = current_tilemaplayer.get_cell_tile_data(tile_coords)
	$"..".register_plant_plot(current_RID, current_tilemaplayer)
	

func _on_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	if body is TileMapLayer:
		_process_tilemap_collision(body, body_rid)
