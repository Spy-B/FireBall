@tool
extends TextureButton

@export var text: String = "Text Button"
@export var arrow_margin_from_center: int = 250

func _ready():
	setup_text()
	hide_arrow()
	set_focus_mode(true)

# warning-ignore:unused_argument
func _process(delta):
	if Engine.is_editor_hint():
		setup_text()
		show_arrow()

func setup_text():
	$RichTextLabel.text = "[center] %s [/center]" % [text]

func show_arrow():
	for arrow in [$PlayerEffect1]:
		arrow.visible = true
		arrow.global_position.y = global_position.y + (size.y / 3.0)
	
	var center_x = global_position.x + (size.x / 1.265)
	$PlayerEffect1.global_position.x = center_x - arrow_margin_from_center

func hide_arrow():
	for arrow in [$PlayerEffect1]:
		arrow.visible = false


func _on_TextureButton_focus_entered():
	show_arrow()

func _on_TextureButton_focus_exited():
	hide_arrow()

func _on_TextureButton_mouse_entered():
	grab_focus()
