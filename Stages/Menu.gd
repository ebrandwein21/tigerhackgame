extends Control

signal start_game()
@onready var buttons_v_box: VBoxContainer = %ButtonsVBox


@onready var ui: CanvasLayer = $"../../UI"



func _ready() -> void:
	pass

func _on_play_pressed() -> void:
	_on_start_game()
	


func _on_quit_pressed() -> void:
	get_tree().quit()

func _on_visibility_changed() -> void:
	if visible:
		focus_button()

func focus_button() -> void:
	if buttons_v_box:
		var button: Button = buttons_v_box.get_child(0)
		if button is Button:
			button.grab_focus()



func _on_start_game() -> void:
	get_tree().change_scene_to_file("res://Stages/world.tscn")
