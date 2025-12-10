extends Area2D

@export var speed: int = 3
@export var DeathParticle: PackedScene

@onready var timer: Timer = $Timer


func _ready() -> void:
	timer.wait_time = 2.0

func _physics_process(_delta) -> void:
	position += Vector2(0, speed * 1)

func _on_Timer_timeout():
	queue_free()

func distroy() -> void:
	var _particle = DeathParticle.instantiate()
	_particle.position = global_position
	_particle.rotation = global_rotation
	_particle.emitting = true
	get_tree().current_scene.add_child(_particle)
	queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Border"):
		timer.start()
		