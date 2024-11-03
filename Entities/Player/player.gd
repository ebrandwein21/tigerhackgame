extends CharacterBody2D

#Physical stats
@export var tile_size:int = 16
@export var move_speed:float = 0.2
@export var move_delay:float = 0.1
@export var can_move = true
@export var money: int	

#component
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var tile_detector: TerrainDetector = $TileDetector
@onready var farm_plots: TileMapLayer = $"../FarmPlots"
@onready var plant_detector: Area2D = $PlantDetector

#Labels
@onready var money_count: Label = $"../StatsUI/Stats/MoneyCount"
@onready var energy_amount: Label = $"../StatsUI/Stats/EnergyAmount"
@onready var score_label: Label = $"../StatsUI/Control/Score"

#Audio
@onready var move_sound: AudioStreamPlayer2D = $Move
@onready var harvest_sound: AudioStreamPlayer2D = $Harvest
@onready var plant_sound: AudioStreamPlayer2D = $Plant

#Stats
@export var energy_max:int = 20
@export var current_energy:int = energy_max
@export var score:int = 0

#Plant refs
@export var corn_ref:PackedScene
@export var carrot_ref:PackedScene
@export var strawberry_ref:PackedScene


#Updates the labels to show the correct values
func set_energy(value:int):
	current_energy = value
	energy_amount.text = (str(current_energy) + "/" + str(energy_max))
	
func set_money(value:int):
	money = value
	money_count.text = (str(money))

func set_score(value:int):
	score = value
	score_label.text = str(score)
	

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animation_player.play("idle")
	energy_amount.text = (str(current_energy) + "/" + str(energy_max))
	money_count.text = (str(money))


func _process(delta: float) -> void:
	#prevents player from spamming things
	if(animation_player.current_animation=="idle"):
		#movement handling
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
			#Selects plant based on number input
			var plant:Plant
			if Input.is_action_pressed("2"):
				plant = corn_ref.instantiate()
			elif Input.is_action_pressed("3"):
				plant = carrot_ref.instantiate()
			elif Input.is_action_pressed("4"):
				plant = strawberry_ref.instantiate()
			if tile_detector.tile_data && current_energy>0  && !plant_detector.active_plant:
				plant_sound.play()
				animation_player.play("planting")
				self.add_child(plant)
				plant.global_position = tile_detector.global_position
				set_energy(current_energy-1)
		elif (Input.is_action_pressed("harvest")):
			if plant_detector.active_plant && plant_detector.active_plant.fully_grown:
				harvest_sound.play()
				animation_player.play("harvest")
				set_money(money+plant_detector.active_plant.yield_amount)
				set_score(score + plant_detector.active_plant.yield_amount*10)
				set_energy(current_energy-1)
				plant_detector.active_plant.remove_plant()
				
	move_and_slide()

#Move animation
func move(input_dir:Vector2) -> void:
	if input_dir:
		if can_move:
			can_move = false
			move_sound.play()
			var tween = create_tween()
			tween.tween_property(self, "global_position", global_position + input_dir*tile_size, move_speed)
			tween.tween_callback(allow_movement).set_delay(move_delay)

#allows this to be called by tween
func allow_movement():
	can_move = true
	
#defaults to idle animation
func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	animation_player.play("idle")

#gets energy
func _on_texture_button_pressed() -> void:
	if money >= 10:
		set_money(money-10)
		set_energy(current_energy+5)
