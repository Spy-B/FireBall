extends Area2D

var speed = 4
var dir = 1
@onready var timeOfDead: Timer = $Timer
var slow_motion = false

func _ready() -> void:
	timeOfDead.wait_time = 3
	timeOfDead.start()

func _physics_process(_delta: float) -> void:
	position += Vector2(speed * -1.5,speed * dir)
	
	if Global.E_trail_is_visible == true:
		$Trail.visible = true
	elif Global.E_trail_is_visible == false:
		$Trail.visible = false

func _on_Timer_timeout() -> void:
	queue_free()
