extends Node2D

func _process(_delta: float) -> void:
	if Input.is_action_just_released("back"):
		self.visible = false
		get_parent().get_node("Buttons").visible = true
