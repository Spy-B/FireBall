extends Node2D

func _physics_process(_delta: float) -> void:
	if Global.score > Global.game_data.Hi_Score:
		Global.sg_save("Hi_Score", Global.score)
	
	if Input.is_action_just_pressed("Window_Min") && get_parent().get_node("Game Over").visible == false:
		get_window().mode = Window.MODE_MINIMIZED if (true) else Window.MODE_WINDOWED
		get_parent().get_node("UI/Pause").visible = true
		get_tree().paused = true
	
	elif Input.is_action_just_pressed("Window_Min") && get_parent().get_node("Game Over").visible == true:
		get_window().mode = Window.MODE_MINIMIZED if (true) else Window.MODE_WINDOWED
	
	if Global.trail_is_visible == true:
		$Player/Trail.visible = true
	elif Global.trail_is_visible == false:
		$Player/Trail.visible = false
	
	if Input.is_action_just_released("Restart"):
		restart_game()

func game_over() -> void:
	if get_parent().get_node("Game Over").visible == false:
		var game_over_timer = Timer.new()
		game_over_timer.connect("timeout", Callable(self, "_on_game_over_timer_timeout"))
		game_over_timer.wait_time = 0.3
		add_child(game_over_timer)
		game_over_timer.start()

func _on_game_over_timer_timeout() -> void:
	restart_game()

func restart_game() -> void:
	$"Game Over".visible = true
	Global.score = 0
	Global.countDown = Global.countDown_h
	Global.coin = 0
