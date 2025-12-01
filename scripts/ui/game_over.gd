extends Control

func _ready() -> void:
	pass

func _physics_process(_delta: float) -> void:
	if self.visible == true:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	if Input.is_action_just_released("Restart"):
		get_tree().change_scene_to_file("res://scenes/world.tscn")
		Engine.time_scale = 1
	
	if Input.is_action_just_released("MainMenu"):
		get_tree().change_scene_to_file("res://scenes/ui/main_menu.tscn")
		Engine.time_scale = 1
	
	if Input.is_action_just_pressed("Window_Min"):
		get_window().mode = Window.MODE_MINIMIZED if (true) else Window.MODE_WINDOWED
	
	$HBoxContainer/HighScore.text = str(Global.game_data.Hi_Score)
