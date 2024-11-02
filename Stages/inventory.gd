extends Node2D



@onready var anim: Sprite2D = $Control/HBoxContainer/Sprite2D
@export var canPress = false





# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:

	if (Input.is_action_pressed("1")):
		anim.frame = 0
	elif (Input.is_action_just_released("1")):
		anim.frame = 4
	elif (Input.is_action_pressed("2")):
		anim.frame = 1
	elif (Input.is_action_just_released("2")):
		anim.frame = 4
	elif (Input.is_action_pressed("3")):
		anim.frame = 2
	elif (Input.is_action_just_released("3")):
		anim.frame = 4
	elif (Input.is_action_pressed("4")):
		anim.frame = 3
	elif (Input.is_action_just_released("4")):
		anim.frame = 4
	
		
	pass




