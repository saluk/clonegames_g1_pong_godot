extends Menu

func init_data() -> void:
	menu_data = [
		"",
		["Rematch", "rematch"],
		["Main Menu", "main_menu"]
	]
	button_class = load("res://UI/MenuButton.tscn")

func rematch() -> void:
	EventManager.rematch.emit()

func main_menu() -> void:
	var main_menu = load("res://UI/MainMenu.tscn")
	get_tree().paused = false
	get_tree().change_scene_to_packed(main_menu)
