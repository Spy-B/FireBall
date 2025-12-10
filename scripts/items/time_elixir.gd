extends Area2D

@export var speed: int = 3
@export var death_particle_scene: PackedScene

@onready var timer: Timer = $Timer

func _ready() -> void:
	timer.wait_time = 2.0

func _physics_process(_delta: float):
	position += Vector2(0, speed * 1)

func distroy():
	var death_particle = death_particle_scene.instantiate()
	death_particle.position = global_position
	death_particle.rotation = global_rotation
	death_particle.emitting = true
	get_tree().current_scene.add_child(death_particle)
	get_parent().get_parent().get_parent().get_node("UI/Countdown/AddTimeAnime").play("AddTime")
	queue_free()

func _on_Timer_timeout():
	queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Border"):
		timer.start()
		