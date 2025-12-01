extends Marker2D

@export var coinPath: PackedScene 
@onready var timer = $Timer

func _ready():
	randomize()
	
	timer.wait_time = randi_range(5, 20)
	timer.start()

func CoinDir():
	var coin = coinPath.instantiate()
	get_parent().add_child(coin)
	coin.position = global_position
	coin.dir = scale.y


func _on_Timer_timeout():
	CoinDir()
