extends Node

@onready var BM1 = $BackgroundMusic
func _ready():
	play()

func play():
	# randomize()
	# var value = (randf_range(0,5))
	
	# if value <= 1:
	# 	BM1.play()
	# elif value > 1 && value <= 2:
	# 	BM2.play()
	pass


func _on_Background_Music_finished():
	play()