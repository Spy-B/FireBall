extends Area2D

@export var speed: float = 5

@onready var time_to_distroy: Timer = $Timer


func _ready() -> void:
	time_to_distroy.wait_time = 2.0

func _physics_process(_delta: float) -> void:
	position += Vector2(0, speed * 1.0)
	
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

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Border"):
		time_to_distroy.start()
