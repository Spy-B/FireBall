extends Node

var trail_is_visible: bool = true
var E_trail_is_visible: bool = true

var score: int = 0
var Hi_score: int = 0
var coin: int = 0

var save_game_path: String = "user://SaveGame.sb"
var save_game_pass: String = "d&iDi3#09u;aLs@"
var game_data: Dictionary = {
	"Hi_Score" : 0,
	"fullscreen_on": false,
	"music_vol": 0,
	"SFX_vol": 0,
	"playertrail": true,
	"enemytrail": true
	}

var camera: Variant = null

var countDown: int = 80
var countDown_h: int = 80


func _ready() -> void:
	if FileAccess.file_exists(save_game_path):
		load_game()
	else:
		save_game()

func save_game(_key: Variant = null ,_val: Variant = null):
	if _key != null && _val != null:
		game_data[_key] = _val

	var save_file: FileAccess = FileAccess.open_encrypted_with_pass(save_game_path,FileAccess.WRITE,save_game_pass)

	save_file.store_var(game_data)
	save_file.close()

func load_game():
	var load_file: FileAccess = FileAccess.open_encrypted_with_pass(save_game_path, FileAccess.READ, save_game_pass)

	game_data = load_file.get_var()
	load_file.close()
