extends Node

func _ready():
	$VBoxContainer/VBoxContainer/Start.grab_focus()

func _on_Start_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene_to_file("res://scenes/world.tscn")
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func _on_Exit_pressed():
	get_tree().quit()

func _on_About_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene_to_file("res://scenes/About game.tscn")


func _on_Control_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene_to_file("res://scenes/Tutorial.tscn")
