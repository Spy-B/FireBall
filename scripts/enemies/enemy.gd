extends CharacterBody2D

var speed: float = 5
var slow_motion: bool = false

#onready var GO = preload("res://scenes/world.tscn")
@onready var timeOfDead: Timer = $Timer


func _ready() -> void:
	timeOfDead.wait_time = 2
	timeOfDead.start()

func _physics_process(_delta: float) -> void:
	position += Vector2(0, speed * 1)
	
	if Global.score >= 10000:
		speed = 6
	
	if Global.score >= 20000:
		speed = 6.5
	
	if Global.score >= 30000:
		speed = 6.8
	
	if Engine.time_scale < 1:
		speed = 0.5
	
	if Global.E_trail_is_visible == true:
		$Trail.visible = true
	elif Global.E_trail_is_visible == false:
		$Trail.visible = false

func _on_Timer_timeout() -> void:
	queue_free()
