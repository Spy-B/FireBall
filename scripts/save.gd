extends Node

@onready var path = "user://config.ini"
#var full_scr = true
var sound_vol = 0
var music_vol = 0
var sfx_vol = 0

func _ready():
	load_config()

func save_config():
	var config = ConfigFile.new()
	config.set_value("audio", "sound", sound_vol)
	config.set_value("audio", "music", music_vol)
	config.set_value("audio", "sfx", sfx_vol)

	var err = config.save(path)
	if err != OK:
		print("can't open")

func load_config():
	var config = ConfigFile.new()
	var default_options = {
			#"full_screen": true,
			"sound": 0,
			"music": 0,
			"sfx": 0
		}

	var err = config.load(path)
	if err != OK:
		return default_options
	var options = {}
	#options.full_screen = config.get_value("full_screen")
	options.sound = config.get_value("audio", "sound")
	options.music = config.get_value("audio", "music")
	options.sfx = config.get_value("audio", "sfx")
	return options
