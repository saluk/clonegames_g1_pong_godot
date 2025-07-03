extends Menu

func init_data() -> void:
	menu_data = [
		"Main Menu",
		["2 Player Match", 
			["2 Player",
				["to 3", "start_match"], 
				["to 5", "start_match"], 
				["to 10", "start_match"]
			]
		],
		"Quit"
	]
	button_class = load("res://UI/MenuButton.tscn")
	
func start_match():
	get_tree().change_scene_to_file("res://Arena/arena.tscn")

func Quit():
	get_tree().quit()
