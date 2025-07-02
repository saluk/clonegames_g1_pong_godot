extends Node

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("reset hotkey"):
		get_tree().paused = false
		get_tree().reload_current_scene()
