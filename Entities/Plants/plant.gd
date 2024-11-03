class_name Plant
extends CharacterBody2D

@onready var plant: Plant = $"."
@onready var area_2d: Area2D = $Area2D
@onready var icon: Sprite2D = $Icon

@export var grow_time:int = 2
@export var yield_amount:float = 10
@export var water_needed:int = 2
var current_water:int = 0
@export var plant_stage:int = 0

var fully_grown:bool=false

var plot_rid : RID
var tile_map:TileMapLayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if plot_rid && tile_map:
		var tile_coords = tile_map.get_coords_for_body_rid(plot_rid)
		var tile_data = tile_map.get_cell_tile_data(tile_coords)
		if tile_data.get_custom_data("is_watered") && !fully_grown:
			current_water+=1
			if current_water>=water_needed:
				current_water = 0
				icon.frame += 1
				if icon.frame-2 >= grow_time:
					fully_grown = true
					return
			tile_map.set_cell(tile_coords, 0, Vector2i(4, 0))
			

# Called every frame. 'delta' is the elapsed time since the previous frame.
func register_plant_plot(rid:RID, tm:TileMapLayer) -> void:
	plot_rid = rid
	tile_map = tm
