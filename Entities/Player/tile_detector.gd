class_name TerrainDetector
extends Area2D

signal terrain_entered(terrain_type)

var current_tilemaplayer: TileMapLayer
var current_is_watered: bool
var current_seed_type: String

func _process_tilemap_collision(body: Node2D, body_rid:RID):
	current_tilemaplayer = body
	#print("entered " + body.to_string())
	
	var collided_tile_coords = current_tilemaplayer.get_coords_for_body_rid(body_rid)
	
	var tile_data = current_tilemaplayer.get_cell_tile_data(collided_tile_coords)
	var is_watered = tile_data.get_custom_data("is_watered")
	var plant_type = tile_data.get_custom_data("plant_type")
	current_is_watered = is_watered
	current_seed_type = plant_type
	 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_shape_exited(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	print("exited " + body.to_string())
	if current_tilemaplayer:
		print("current " + current_tilemaplayer.to_string())
	else:
		print("current NULL")

func _on_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	print("entered " + body.to_string())
	if body is TileMapLayer:
		_process_tilemap_collision(body, body_rid)

#
