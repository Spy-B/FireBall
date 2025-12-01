extends CharacterBody2D


var speed = 3
var dir = 1 
@onready var timeOfA_T = $Timer
@export var DeathParticle: PackedScene

func _ready() -> void:
	timeOfA_T.set_wait_time(5)
	timeOfA_T.start()

func _physics_process(_delta) -> void:
	position += Vector2(0,speed * dir)

func _on_Timer_timeout():
	queue_free()

func kill() -> void:
	var _particle = DeathParticle.instantiate()
	_particle.position = global_position
	_particle.rotation = global_rotation
	_particle.emitting = true
	get_tree().current_scene.add_child(_particle)
	queue_free()

func _on_Area2D_body_entered(body) -> void:
	if body.is_in_group("Player"):
#		body.AttackZone()
		kill()
