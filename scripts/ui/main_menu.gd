extends Control

func _ready():
	$ColorRect2/AnimationPlayer.play("Opening")

func _physics_process(_delta) -> void:
	if Input.is_action_just_released("start"):
# warning-ignore:return_value_discarded
		get_tree().change_scene_to_file("res://scenes/world.tscn")
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	
	if Input.is_action_just_released("ui_cancel"):
		$AYS.visible = true
	
	if Input.is_action_just_released("ui_accept") && $AYS.visible == true:
		get_tree().quit()
	elif Input.is_action_just_released("back") && $AYS.visible == true:
		$AYS.visible = false
	
	$Buttons/Exit/AnimationPlayer.play("Exit_B_E")
	
	if Input.is_action_just_released("about"):
		$AboutGame.visible = true
		$Buttons.visible = false
	
	if Input.is_action_just_released("options"):
		$Settings.visible = true

	if Input.is_action_just_pressed("Window_Min"):
		get_window().mode = Window.MODE_MINIMIZED if (true) else Window.MODE_WINDOWED
