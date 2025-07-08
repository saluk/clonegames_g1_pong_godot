extends Button

func _ready() -> void:
	mouse_entered.connect(enter_focus)
	mouse_exited.connect(exit_focus)
	focus_entered.connect(enter_focus)
	focus_exited.connect(exit_focus)
	
func enter_focus() -> void:
	pass
	
func exit_focus() -> void:
	pass
