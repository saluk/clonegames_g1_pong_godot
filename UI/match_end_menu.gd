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
	SceneManager.change_scene("res://UI/MainMenu.tscn")
