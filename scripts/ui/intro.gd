extends Control

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	$AnimationPlayer.play("Fade in")
	await get_tree().create_timer(3).timeout
	$AnimationPlayer.play("Fade out")
	await get_tree().create_timer(2).timeout
	get_tree().change_scene_to_file("res://scenes/ui/main_menu.tscn")
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
