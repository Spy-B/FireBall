extends CharacterBody2D

var speed = 3
var dir = 1 
@onready var timeOfA_T = $Timer
@export var death_particle_scene: PackedScene

func _ready() -> void:
	timeOfA_T.set_wait_time(5)
	timeOfA_T.start()

func _physics_process(_delta: float):
	position += Vector2(0,speed * dir)

func _on_Timer_timeout():
	queue_free()

func kill():
	var death_particle = death_particle_scene.instantiate()
	death_particle.position = global_position
	death_particle.rotation = global_rotation
	death_particle.emitting = true
	get_tree().current_scene.add_child(death_particle)
	Global.countDown += 10
	get_parent().get_parent().get_parent().get_node("GUI/Countdown/AddTimeAnime").play("AddTime")
	queue_free()

func _on_Area2D_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		kill()

func _on_Area2D2_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		kill()
