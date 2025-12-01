extends Camera2D

var shake_amount: float = 0
var default_offset = offset
var tween: Tween

@onready var timer = $Timer


func _ready() -> void:
	set_process(false)
	Global.camera = self
	randomize()

func _process(_delta: float) -> void:
	offset = Vector2(randf_range(-1 ,1) * shake_amount, randf_range(-1, 1) * shake_amount)
	

func shake(time, amount) -> void:
	timer.wait_time = time
	shake_amount = amount
	set_process(true)
	timer.start()

func _on_Timer_timeout() -> void:
	set_process(false)
	tween = get_tree().create_tween()
	tween.tween_property(self, "offset", default_offset, 0.1)
