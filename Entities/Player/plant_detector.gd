extends Area2D

var active_plant:Plant

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	if body is Plant:
		active_plant = body
		


func _on_body_exited(body: Node2D) -> void:
	if active_plant == body:
		active_plant = null