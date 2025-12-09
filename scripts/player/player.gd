extends CharacterBody2D

var speed: int = 400

var master_bus = AudioServer.get_bus_index("Master")
var GO_bus = AudioServer.get_bus_index("Game Over")

@export var death_particle_scene: PackedScene
@export var phone_controllers: Control
@export var joystick_base: Node2D

@onready var trail: Line2D = $Trail
@onready var defense_zone: Area2D = $DefenseZone
@onready var game_over: Control = $"../UI/GameOver"


func _physics_process(_delta: float) -> void:
	if (OS.get_name() == "Android"):
		velocity = joystick_base.joystick.get_value() * speed
	
	elif (OS.get_name() == "Linux" || OS.get_name() == "Windows"):
		velocity = Input.get_vector("move_left", "move_right", "move_up", "move_down") * speed
		phone_controllers.visible = false
	
	move_and_slide()

	
	if Global.score >= 10000:
		speed = 450
	
	if Global.score >= 20000:
		speed = 500
	
	if Global.score >= 30000:
		speed = 550
	
	if Global.score >= 50000:
		speed = 600
		trail.width = 8
	

	if Global.trail_is_visible == true:
		trail.visible = true
	elif Global.trail_is_visible == false:
		trail.visible = false

func _process(_delta: float) -> void:
	# fps_label.text = str("FPS : ", Engine.get_frames_per_second())
	pass


func distroy() -> void:
	Engine.time_scale = 0.2
	shake()
	Input.vibrate_handheld(500)
	visible = false
	$CollisionShape2D.visible = false
	$Hotbox.visible = false

	var death_particle = death_particle_scene.instantiate()
	death_particle.position = global_position
	death_particle.rotation = global_rotation
	death_particle.emitting = true
	get_tree().current_scene.add_child(death_particle)


func finish_game() -> void:
	if game_over.visible == false:
		distroy()
		var game_over_timer = Timer.new()
		game_over_timer.connect("timeout", Callable(self, "restart_game"))
		game_over_timer.wait_time = 0.3
		add_child(game_over_timer)
		game_over_timer.start()

func restart_game() -> void:
	game_over.visible = true
	Global.score = 0
	Global.countDown = Global.countDown_h
	Global.coin = 0

func shake() -> void:
	Global.camera.shake(1,2)

func AttackZone() -> void:
	$AttackZone.visible = true


func _on_hotbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("Enemy"):
		finish_game()

	if area.is_in_group("Coin"):
		Global.coin += 1
		area.distroy()

	if area.is_in_group("TimeElixir"):
		Global.countDown += 10
		area.distroy()

	if area.is_in_group("DefenseElixir"):
		defense_zone.visible = true
		defense_zone.get_node("CollisionShape2D").set_deferred("disabled", false)
		area.distroy()


func _on_defense_zone_area_entered(area: Area2D) -> void:
	if area.is_in_group("Enemy"):
		area.queue_free()
