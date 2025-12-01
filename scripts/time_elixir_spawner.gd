extends Marker2D

@export var timeElixirPath: PackedScene
@onready var timer = $Timer

func _ready():
	randomize()
	
	timer.set_wait_time(randf_range(60,30))
	timer.start()

func create_instance():
	var timeElixir = timeElixirPath.instantiate()
	get_parent().add_child(timeElixir)
	timeElixir.position = global_position
	timeElixir.dir = scale.y

func _on_Timer_timeout():
	create_instance()
