extends Marker2D

@export var enemyPath: PackedScene
var shootEnemy = 0
@onready var timer: Timer = $Timer

func _ready():
	randomize()

	timer.wait_time = randf_range(5, 35)
	timer.start()

func enemyDir():
	var enemy = enemyPath.instantiate()
	get_parent().add_child(enemy)
	enemy.position = global_position

func _on_Timer_timeout():
	enemyDir()
