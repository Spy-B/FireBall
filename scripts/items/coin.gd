extends CharacterBody2D

var speed: int = 2
var dir: int = 1
@export var death_particle_path: PackedScene

@onready var timeDead: Timer = $Timer


func _ready() -> void:
	timeDead.set_wait_time(5)
	timeDead.start()

func _physics_process(delta: float) -> void:
	position += Vector2(delta,speed * dir)

func kill() -> void:
	var death_particle: CPUParticles2D = death_particle_path.instantiate()
	death_particle.position = global_position
	death_particle.rotation = global_rotation
	death_particle.restart()
	get_tree().current_scene.add_child(death_particle)

func _on_Area2D_body_entered(body):
	if body.is_in_group("Player"):
		Global.coin += 1
		kill()
		queue_free()


func _on_Timer_timeout() -> void:
	queue_free()
