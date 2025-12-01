extends Control

var master_bus = AudioServer.get_bus_index("Master")
var music_bus = AudioServer.get_bus_index("Music")
var sfx_bus = AudioServer.get_bus_index("SFX")


@onready var fullscreen: CheckButton = $FullScreen/CheckButton
@onready var master_vol: HSlider = $MasterVolume/HSlider
@onready var music_vol: HSlider = $MusicVolume/HSlider
@onready var sfx_vol: HSlider = $SFXVolume/HSlider
@onready var player_trail: CheckButton = $PlayerTrail/CheckButton
@onready var enemy_trail: CheckButton = $EnemyTrail/CheckButton


func _ready() -> void:
	master_vol.value = SaveSetting.sound_vol
	music_vol.value = SaveSetting.music_vol
	sfx_vol.value = SaveSetting.sfx_vol

func _process(delta) -> void:
	AudioServer.get_bus_volume_db(delta)

	if Input.is_action_just_pressed("back"):
		self.visible = false


func _on_OptionButton_pressed() -> void:
	get_window().mode = Window.MODE_EXCLUSIVE_FULLSCREEN if (!((get_window().mode == Window.MODE_EXCLUSIVE_FULLSCREEN) or (get_window().mode == Window.MODE_FULLSCREEN))) else Window.MODE_WINDOWED

func _on_HSlider_value_changed(value) -> void:
	AudioServer.set_bus_volume_db(music_bus, value)
	SaveSetting.music_vol = value
	
	if value == -20:
		AudioServer.set_bus_mute(music_bus, true)
	
	else:
		AudioServer.set_bus_mute(music_bus, false)
	
	music_vol.value = SaveSetting.music_vol
	SaveSetting.save_config()


func _on_HSlider2_value_changed(value) -> void:
	AudioServer.set_bus_volume_db(sfx_bus, value)
	SaveSetting.sfx_vol = value
	
	if value == -20:
		AudioServer.set_bus_mute(sfx_bus, true)
	
	else:
		AudioServer.set_bus_mute(sfx_bus, false)

func _on_HSlider3_value_changed(value) -> void:
	AudioServer.set_bus_volume_db(master_bus, value)
	SaveSetting.sound_vol = value
	
	if value == -20:
		AudioServer.set_bus_mute(master_bus, true)
	
	else:
		AudioServer.set_bus_mute(master_bus, false)

func _on_CheckBox_pressed() -> void:
	Global.trail_is_visible = !Global.trail_is_visible

func _on_CheckBox2_pressed() -> void:
	Global.E_trail_is_visible = !Global.E_trail_is_visible

func _on_HSlider_changed():
	master_vol = SaveSetting.sound_vol
	SaveSetting.save_config()
