extends Control

@export var joystick: Node2D
@export var pause_button: TouchScreenButton

@onready var game_over: Control = $"../../UI/GameOver"

func _process(_delta: float) -> void:
	if Input.is_action_just_released("ui_cancel") && game_over.visible == false:
		var new_pause_state = not get_tree().paused
		get_tree().paused = new_pause_state
		visible = new_pause_state
		joystick.visible = !joystick.visible
		pause_button.visible = !pause_button.visible
	
	if Input.is_action_just_released("resume"):
		get_tree().paused = false
		self.visible = false
		joystick.visible = !joystick.visible
		pause_button.visible = !pause_button.visible

	if Input.is_action_just_released("Restart"):
		get_tree().paused = false
		Global.score = 0
		Global.countDown = Global.countDown_h
		get_tree().reload_current_scene()
	
	if Input.is_action_just_released("options") && game_over.visible == false:
		$Settings.visible = true
	
	if Input.is_action_just_released("MainMenu"):
		get_tree().paused = false
		Global.score = 0
		Global.countDown = Global.countDown_h
		get_tree().change_scene_to_file("res://scenes/ui/main_menu.tscn")
		
#	if self.visible == true:
#		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
#
#	elif self.visible == false && get_parent().get_parent().get_node("Game Over").visible == false:
#		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	if Input.is_action_just_pressed("Window_Min"):
		get_window().mode = Window.MODE_MINIMIZED if (true) else Window.MODE_WINDOWED
