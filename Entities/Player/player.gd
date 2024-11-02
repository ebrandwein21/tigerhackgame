extends CharacterBody2D

@export var tile_size:int = 16
@export var move_speed:float = 0.2
@export var move_delay:float = 0.1
@export var can_move = true

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var tile_detector: TerrainDetector = $TileDetector
@onready var sprite_2d: Sprite2D = $Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animation_player.play("idle")

func _process(delta: float) -> void:
	if (Input.is_action_pressed("right")):
		move(Vector2(1,0))
	elif (Input.is_action_pressed("left")):
		move(Vector2(-1,0))
	elif (Input.is_action_pressed("up")):
		move(Vector2(0,-1))
	elif (Input.is_action_pressed("down")):
		move(Vector2(0,1))
	elif (Input.is_action_pressed("water")):
		if !tile_detector.current_is_watered:
			animation_player.play("water")
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
