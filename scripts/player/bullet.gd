extends CharacterBody2D

var speed = 300
var shooter = null

func _physics_process(delta: float) -> void:
	var collision_info = move_and_collide(velocity.normalized() * delta * speed)

func _on_Area2D_body_entered(body) -> void:
	if body == shooter:
		return
	
	queue_free()
