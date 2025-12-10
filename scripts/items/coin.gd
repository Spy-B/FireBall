extends Area2D

@export var speed: int = 2
@export var death_particle_path: PackedScene


@onready var timer: Timer = $Timer


func _ready() -> void:
	timer.set_wait_time(5)

func _physics_process(_delta: float) -> void:
	position += Vector2(0, speed * 1)

func distroy() -> void:
	var death_particle: CPUParticles2D = death_particle_path.instantiate()
	death_particle.position = global_position
	death_particle.rotation = global_rotation
	death_particle.restart()
	get_tree().current_scene.add_child(death_particle)
	queue_free()

func _on_Timer_timeout() -> void:
	queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Border"):
		timer.start()
