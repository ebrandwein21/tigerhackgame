extends CanvasLayer


@onready var MUSIC_BUS_ID = AudioServer.get_bus_index("Music")
@onready var SFX_BUS_ID = AudioServer.get_bus_index("SFX")
@onready var MASTER_BUS_ID = AudioServer.get_bus_index("Master")
@onready var options: Control = $Options

@onready var master_amount: Label = $Options/MarginContainer/VBoxContainer/GridContainer/Control3/MasterAmount
@onready var music_amount: Label = $Options/MarginContainer/VBoxContainer/GridContainer/Control2/MusicAmount
@onready var sfx_amount: Label = $Options/MarginContainer/VBoxContainer/GridContainer/Control/SFXAmount

@onready var master_slider: HSlider = $Options/MarginContainer/VBoxContainer/GridContainer/MasterSlider
@onready var music_slider: HSlider = $Options/MarginContainer/VBoxContainer/GridContainer/MusicSlider
@onready var sfx_slider: HSlider = $Options/MarginContainer/VBoxContainer/GridContainer/SFXSlider

@export var active_menus:Array = [] #should only have Control types

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	options.visible = false
	
	master_slider.value = SoundVolume.master_vol
	master_amount.text = str(SoundVolume.master_vol*100)
	music_slider.value = SoundVolume.music_vol
	music_amount.text = str(SoundVolume.music_vol*100)
	sfx_slider.value = SoundVolume.sfx_vol
	sfx_amount.text = str(SoundVolume.sfx_vol*100)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		if(active_menus.is_empty()):
			options.visible = true
			active_menus.append(options)
		else:
			#print(active_menus.pop_back())
			var closed_menu = active_menus.pop_back()
			closed_menu.visible = false




func _on_master_slider_value_changed(value: float) -> void:
	SoundVolume.set_master_volume(value)
	master_amount.text = str(value*100)

func _on_music_slider_value_changed(value: float) -> void:
	SoundVolume.set_music_volume(value)
	music_amount.text = str(value*100)
	
func _on_sfx_slider_value_changed(value: float) -> void:
	SoundVolume.set_sfx_volume(value)
	sfx_amount.text = str(value*100)



func _on_quit_pressed() -> void:
	get_tree().quit()
