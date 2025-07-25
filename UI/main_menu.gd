extends Menu

func init_data() -> void:
	menu_data = [
		"Main Menu",
		["1 Player", func()->void: self.start_match(1, 3)],
		["2 Player Match", 
			["2 Player",
				["to 3", func()->void: self.start_match(2, 3)], 
				["to 5", func()->void: self.start_match(2, 5)], 
				["to 10", func()->void: self.start_match(2, 10)]
			]
		],
		"Quit"
	]
	button_class = load("res://UI/MenuButton.tscn")
	
func start_match(players:int, goals:int)->void:
	SceneManager.change_scene(
		"res://Arena/arena.tscn", 
		EventManager.start_new_match, 
		[players, goals]
	)

func Quit()->void:
	get_tree().quit()
