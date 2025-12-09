extends Control

@onready var buttons: Control = $Buttons
@onready var quit_dialog: Control = $QuitDialog
@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _ready():
	animation_player.play("Opening")

func _process(_delta) -> void:
	if Input.is_action_just_released("start"):
		get_tree().change_scene_to_file("res://scenes/world.tscn")
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	
	if Input.is_action_just_released("ui_cancel"):
		quit_dialog.visible = true
	
	if Input.is_action_just_released("ui_accept") && quit_dialog.visible == true:
		get_tree().quit()
	elif Input.is_action_just_released("back") && quit_dialog.visible == true:
		quit_dialog.visible = false
	
	if Input.is_action_just_released("about"):
		$AboutGame.visible = true
		$Buttons.visible = false
	
	if Input.is_action_just_released("options"):
		$Settings.visible = true

	if Input.is_action_just_pressed("Window_Min"):
		get_window().mode = Window.MODE_MINIMIZED if (true) else Window.MODE_WINDOWED
