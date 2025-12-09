extends Node2D

@export var player: CharacterBody2D
var player_spawn_point: float

@onready var camera: Camera2D = $Camera2D
@onready var pause: Control = $UI/Pause
@onready var game_over: Control = $UI/GameOver

func _ready() -> void:
	player.global_position.x = DisplayServer.screen_get_size().x / 2.0 / camera.zoom.x

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
