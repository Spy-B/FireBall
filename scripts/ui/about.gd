extends Control

@onready var buttons: Control = $"../Buttons"

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("back"):
		self.visible = false
		buttons.visible = true
