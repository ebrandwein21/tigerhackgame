extends CharacterBody2D

@export var move_amount:int = 16

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _unhandled_input(event: InputEvent) -> void:
	if (event.is_action_pressed("right")):
		global_position.x += move_amount
	if (event.is_action_pressed("left")):
		global_position.x += -move_amount
	if (event.is_action_pressed("up")):
		global_position.y += -move_amount
	if (event.is_action_pressed("down")):
		global_position.y += move_amount

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
