extends Node

@onready var MASTER_BUS_ID = AudioServer.get_bus_index("Master")
@onready var MUSIC_BUS_ID = AudioServer.get_bus_index("Music")
@onready var SFX_BUS_ID = AudioServer.get_bus_index("SFX")

var master_vol = .5
var music_vol = 1.
var sfx_vol = 1.

func _ready() -> void:
	set_master_volume(master_vol)
	set_sfx_volume(sfx_vol)
	set_music_volume(music_vol)

func set_master_volume(value:float) -> void:
	AudioServer.set_bus_volume_db(MASTER_BUS_ID, linear_to_db(value))
	AudioServer.set_bus_mute(MASTER_BUS_ID, value < .01)
	master_vol = value

func set_music_volume(value:float) -> void:
	AudioServer.set_bus_volume_db(MUSIC_BUS_ID, linear_to_db(value))
	AudioServer.set_bus_mute(MUSIC_BUS_ID, value < .01)
	music_vol = value

func set_sfx_volume(value:float) -> void:
	AudioServer.set_bus_volume_db(SFX_BUS_ID, linear_to_db(value))
	AudioServer.set_bus_mute(SFX_BUS_ID, value < .01)
	sfx_vol = value
