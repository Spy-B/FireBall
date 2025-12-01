extends Marker2D

@export var defenseBallPath: PackedScene
@onready var timer = $Timer

func _ready():
	randomize()
	
	timer.wait_time = randi_range(35, 50)
	timer.start()

func create():
	var defenseBall = defenseBallPath.instantiate()
	get_parent().add_child(defenseBall)
	defenseBall.position = global_position
	defenseBall.dir = scale.y

func _on_Timer_timeout():
	create()
