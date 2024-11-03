extends Area2D

var active_plant:Plant

#Sets active plant to the plant it touches
func _on_body_entered(body: Node2D) -> void:
	if body is Plant:
		active_plant = body
		

#gets rid of active plant if no new plant
func _on_body_exited(body: Node2D) -> void:
	if active_plant == body:
		active_plant = null
