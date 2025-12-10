extends Node2D

@export var player: CharacterBody2D

@onready var camera: Camera2D = $Camera2D
@onready var world_borders: Node2D = $WorldBorders
@onready var pause: Control = $UI/Pause
@onready var game_over: Control = $UI/GameOver

func _ready() -> void:
	var screen_size: Vector2 = DisplayServer.screen_get_size()

	player.global_position.x = screen_size.x / 2.0 / camera.zoom.x


	world_borders.get_node("Border2").global_position.x = screen_size.x / camera.zoom.x + 14 # screen area
	print(world_borders.get_node("Border2").global_position.x)

	world_borders.get_node("Border1").global_position.x = screen_size.x / 2.0
	world_borders.get_node("Border1").get_node("CollisionShape2D").shape.size.x = screen_size.x

	world_borders.get_node("Border3").global_position.x = screen_size.x / 2.0
	world_borders.get_node("Border3").get_node("CollisionShape2D").shape.size.x = screen_size.x

func _process(_delta: float) -> void:
	if Global.score > Global.game_data.Hi_Score:
		Global.save_game("Hi_Score", Global.score)
	
	if Global.trail_is_visible == true:
		$Player/Trail.visible = true
	elif Global.trail_is_visible == false:
		$Player/Trail.visible = false

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("Window_Min") && game_over.visible == false:
		get_window().mode = Window.MODE_MINIMIZED if (true) else Window.MODE_WINDOWED
		get_parent().get_node("UI/Pause").visible = true
		get_tree().paused = true

	if event.is_action_pressed("Window_Min") && game_over.visible == true:
		get_window().mode = Window.MODE_MINIMIZED if (true) else Window.MODE_WINDOWED


func finish_game() -> void:
	if game_over.visible == false:
		var game_over_timer = Timer.new()
		game_over_timer.connect("timeout", Callable(self, "restart_game"))
		game_over_timer.wait_time = 0.3
		add_child(game_over_timer)
		game_over_timer.start()

func restart_game() -> void:
	$"Game Over".visible = true
	Global.score = 0
	Global.countDown = Global.countDown_h
	Global.coin = 0
