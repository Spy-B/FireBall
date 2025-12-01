extends Label

@onready var add_score_timer = $Timer

func _ready():
	add_score_timer.wait_time = 0.02
	add_score_timer.start()

func _process(_delta: float) -> void:
	self.text = str(Global.score)

func _on_Timer_timeout():
	Global.score += 1
