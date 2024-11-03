extends CharacterBody2D

@export var tile_size:int = 16
@export var move_speed:float = 0.2
@export var move_delay:float = 0.1
@export var can_move = true
@export var money: int	

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var tile_detector: TerrainDetector = $TileDetector
@onready var farm_plots: TileMapLayer = $"../FarmPlots"
@onready var plant_detector: Area2D = $PlantDetector
@onready var money_count: Label = $"../StatsUI/Stats/MoneyCount"
@onready var energy_amount: Label = $"../StatsUI/Stats/EnergyAmount"



@export var energy_max:int = 20
@export var current_energy:int = energy_max
@export var corn_ref:PackedScene
@export var carrot_ref:PackedScene
@export var strawberry_ref:PackedScene

func set_energy(value:int):
	current_energy = value
	energy_amount.text = (str(current_energy) + "/" + str(energy_max))
	
func set_money(value:int):
	money = value
	money_count.text = (str(money))

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animation_player.play("idle")
	energy_amount.text = (str(current_energy) + "/" + str(energy_max))
	money_count.text = (str(money))

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
				set_energy(current_energy-1)
				tile_detector.current_tilemaplayer.set_cell(tile_detector.tile_coords, 0, Vector2i(5, 0))
				animation_player.play("water")
		elif (Input.is_action_pressed("2") || Input.is_action_pressed("3") || Input.is_action_pressed("4")):
			var plant:Plant
			if Input.is_action_pressed("2"):
				plant = corn_ref.instantiate()
			elif Input.is_action_pressed("3"):
				plant = carrot_ref.instantiate()
			elif Input.is_action_pressed("4"):
				plant = strawberry_ref.instantiate()
			if tile_detector.tile_data && current_energy>0  && !plant_detector.active_plant:
				set_energy(current_energy-1)
				animation_player.play("planting")
				self.add_child(plant)
				plant.global_position = tile_detector.global_position
		elif (Input.is_action_pressed("harvest")):
			if plant_detector.active_plant && plant_detector.active_plant.fully_grown:
				animation_player.play("harvest")
				set_money(money+plant_detector.active_plant.yield_amount)
				plant_detector.active_plant.remove_plant()
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
