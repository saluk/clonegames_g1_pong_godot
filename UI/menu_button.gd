extends Button
class_name MyMenuButton

var next_shift := 0.0
var is_selected := false

func _ready() -> void:
	mouse_entered.connect(enter_focus)
	mouse_exited.connect(exit_focus)
	focus_entered.connect(enter_focus)
	focus_exited.connect(exit_focus)
	
func enter_focus() -> void:
	is_selected = true
	next_shift = 0.0
	grab_focus()
	
func exit_focus() -> void:
	is_selected = false
	remove_theme_font_size_override("font_size")

func _process(dt:float) -> void:
	if is_selected:
		next_shift += dt
		var size_adjust := sin(next_shift*6)*2+2
		add_theme_font_size_override("font_size", int(8+size_adjust))
