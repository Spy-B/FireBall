extends CharacterBody2D

var motion = Vector2()
var speed = 400

var master_bus = AudioServer.get_bus_index("Master")
var GO_bus = AudioServer.get_bus_index("Game Over")


@export var death_particle_scene: PackedScene
@export var joystick: Node2D


@onready var game_over: Control = $"../UI/GameOver"


func _physics_process(_delta: float) -> void:
	if (OS.get_name() == "Android"):
		velocity = joystick.get_node("Joystick_F").get_value() * speed
	
	if (OS.get_name() == "Linux"):
		velocity = Input.get_vector("move_left", "move_right", "move_up", "move_down") * speed
	
	
	move_and_slide()

	
	if Global.score >= 10000:
		speed = 450
	
	if Global.score >= 20000:
		speed = 500
	
	if Global.score >= 30000:
		speed = 550
	
	if Global.score >= 50000:
		speed = 600
		$Trail.width = 8
	
	if Global.score > Global.game_data.Hi_Score:
		Global.save_game("Hi_Score", Global.score)
	
	if Input.is_action_just_pressed("Window_Min") && get_parent().get_node("GameOver").visible == false:
		get_window().mode = Window.MODE_MINIMIZED if (true) else Window.MODE_WINDOWED
		get_parent().get_node("UI/Pause").visible = true
		get_tree().paused = true
	
	elif Input.is_action_just_pressed("Window_Min") && get_parent().get_node("GameOver").visible == true:
		get_window().mode = Window.MODE_MINIMIZED if (true) else Window.MODE_WINDOWED
	
	if Global.trail_is_visible == true:
		$Trail.visible = true
	elif Global.trail_is_visible == false:
		$Trail.visible = false

func _process(_delta: float) -> void:
	# get_parent().get_node("UI/FPS").text = str("FPS : ", Engine.get_frames_per_second())
	pass

func kill() -> void:
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

func restart_game() -> void:
	game_over.visible = true
	Global.score = 0
	Global.countDown = Global.countDown_h
	Global.coin = 0

func finish_game() -> void:
	if game_over.visible == false:
		kill()
		var game_over_timer = Timer.new()
		game_over_timer.connect("timeout", Callable(self, "_on_game_over_timer_timeout"))
		game_over_timer.wait_time = 0.3
		add_child(game_over_timer)
		game_over_timer.start()

func _on_game_over_timer_timeout() -> void:
	restart_game()

func shake() -> void:
	Global.camera.shake(1,2)

func AttackZone() -> void:
	$AttackZone.visible = true

func _on_Hotbox_body_entered(body) -> void:
	if body.is_in_group("Enemy"):
		finish_game()
		get_parent().get_node("BackgroundMusic/BackgroundMusic").set_bus("GameOver")
		get_parent().get_node("BackgroundMusic/BackgroundMusic2").set_bus("GameOver")
	if body.is_in_group("Attack"):
		body.kill()


func _on_AttackZone_body_entered(body) -> void:
	if body.is_in_group("Enemy"):
		body.dead()
