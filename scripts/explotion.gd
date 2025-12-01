extends CPUParticles2D

@onready var timecreated = Time.get_ticks_msec()

func _process(_delta) -> void:
	if Time.get_ticks_msec() - timecreated > 10000:
		queue_free()
