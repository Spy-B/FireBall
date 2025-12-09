extends TouchScreenButton

var radius = Vector2(250,250)
var boundary = 500
var ongoing_drag = -1
var return_accel = 50
var threshold = 10

func _process(delta: float) -> void:
	if ongoing_drag == -1:
		var pos_difference = (Vector2(0,0) - radius) - position
		position += pos_difference * return_accel * delta

func get_Button_Pos() -> Vector2:
	return position + radius

func _input(event: InputEvent) -> void:
	if event is InputEventScreenDrag or (event is InputEventScreenTouch and event.is_pressed()):
		var event_dist_from_center = (event.position -get_parent().global_position).length()
		
		if event_dist_from_center <= boundary * global_scale.x or event.get_index() == ongoing_drag:
			set_global_position(event.position - radius * global_scale)
		
			if get_Button_Pos().length() > boundary:
				set_position(get_Button_Pos().normalized() * boundary - radius)
		
			ongoing_drag = event.get_index()
	if event is InputEventScreenTouch and !event.is_pressed() and event.get_index() == ongoing_drag:
		ongoing_drag = -1
	
func get_value() -> Vector2:
	if get_Button_Pos().length() > threshold:
		return get_Button_Pos().normalized()
	return Vector2(0,0)
