extends Node

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("reset hotkey"):
		EventManager.rematch.emit()
	if event.is_action_pressed("points hotkey"):
		EventManager.score_update.emit([1,randi_range(1,9)])
