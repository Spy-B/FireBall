extends CharacterBody2D

var speed = 4
var dir = 1
@onready var timeDead = $Timer

func _ready() -> void:
	timeDead.set_wait_time(2)
	timeDead.start()

func _physics_process(_delta: float) -> void:
	position += Vector2(0,speed * dir)
	
	if Global.score >= 10000:
		speed = 5
	
	if Global.score >= 20000:
		speed = 5.5
	
	if Global.score >= 30000:
		speed = 6
	
	if Global.score >= 50000:
		speed = 6.5
	
	if Engine.time_scale < 1:
		speed = 0.5
	
	if Global.E_trail_is_visible == true:
		$Trail.visible = true
	elif Global.E_trail_is_visible == false:
		$Trail.visible = false

func dead() -> void:
	queue_free()
	pass

func _on_Timer_timeout() -> void:
	dead()
