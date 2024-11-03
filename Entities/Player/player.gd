extends CharacterBody2D

@export var tile_size:int = 16
@export var move_speed:float = 0.2
@export var move_delay:float = 0.1
@export var can_move = true
@export var plant:Plant
@export var money:int = 0

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var tile_detector: TerrainDetector = $TileDetector
@onready var farm_plots: TileMapLayer = $"../FarmPlots"
@onready var plant_detector: Area2D = $PlantDetector

@export var energy_max:int = 10
@export var current_energy:int = energy_max
@export var plant_ref:PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animation_player.play("idle")

func _process(delta: float) -> void:
	if(animation_player.current_animation=="idle"):
		if (Input.is_action_pressed("right")):
			move(Vector2(1,0))
		elif (Input.is_action_pressed("left")):
			move(Vector2(-1,0))
		elif (Input.is_action_pressed("up")):
			move(Vector2(0,-1))
		elif (Input.is_action_pressed("down")):
			move(Vector2(0,1))
		elif (Input.is_action_pressed("1")):
			if tile_detector.tile_data && current_energy>0 && !tile_detector.tile_data.get_custom_data("is_watered"):
				current_energy-=1
				tile_detector.current_tilemaplayer.set_cell(tile_detector.tile_coords, 0, Vector2i(5, 0))
				animation_player.play("water")
		elif (Input.is_action_pressed("2") || Input.is_action_pressed("3") || Input.is_action_pressed("4")):
			if tile_detector.tile_data && current_energy>0  && !plant_detector.active_plant:
				animation_player.play("planting")
				var plant = plant_ref.instantiate()
				self.add_child(plant)
				plant.global_position = tile_detector.global_position
		elif (Input.is_action_pressed("harvest")):
			if plant_detector.active_plant.fully_grown:
				animation_player.play("harvest")
				plant_detector.active_plant.queue_free()
	move_and_slide()

	
	

func move(input_dir:Vector2) -> void:
	if input_dir:
		if can_move:
			can_move = false
			var tween = create_tween()
			tween.tween_property(self, "global_position", global_position + input_dir*tile_size, move_speed)
			tween.tween_callback(allow_movement).set_delay(move_delay)

func allow_movement():
	can_move = true
	

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	animation_player.play("idle")
