class_name TerrainDetector
extends Area2D

signal terrain_entered(terrain_type)

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

	
	 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_shape_exited(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	if current_RID == body_rid:
		tile_data = null
		

func _on_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	if body is TileMapLayer:
		_process_tilemap_collision(body, body_rid)

#
