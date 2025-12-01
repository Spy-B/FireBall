extends Marker2D

@export var enemyPath: PackedScene
var shootEnemy: int = 0
@onready var timer: Timer = $Timer

func _ready() -> void:
	randomize()

	timer.wait_time = randf_range(35,3)
	timer.start()

func enemyDir() -> void:
	var enemy = enemyPath.instantiate()
	get_parent().add_child(enemy)
	enemy.position = global_position
	enemy.dir = scale.y
	pass

func _on_Timer_timeout() -> void:
	enemyDir()
	pass # Replace with function body.
