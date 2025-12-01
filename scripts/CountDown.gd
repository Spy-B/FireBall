extends Label

@onready var CountDown = $Timer
@onready var game_over: Control = $"../../UI/GameOver"

func _ready():
	CountDown.wait_time = 1
	CountDown.start()

func _physics_process(_delta) -> void:
	self.text = str(Global.countDown)
	
	if self.text == str(0):
		game_over.visible = true
		Global.score = 0
		Global.countDown = Global.countDown_h
		#get_parent().get_parent().get_node("Background Music").set_bus("Game Over")
		if get_parent().get_parent().get_node("Player").visible == true:
			queue_free()

func _on_Timer_timeout() -> void:
	Global.countDown -= 1
