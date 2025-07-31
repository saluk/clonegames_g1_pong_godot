extends Menu

func _ready() -> void:
	%ControlsBackButton.pressed.connect(
		func()->void:
			%ControlsPanel.visible = false
			%ControlsBackButton.focus_mode = FOCUS_NONE
			%buttons.focus_mode = FOCUS_ALL
			%buttons.visible = true
			%buttons.get_child(2).grab_focus()
	)
	super._ready()

func init_data() -> void:
	menu_data = [
		"",
		["1 Player", func()->void: self.start_match(1, 3)],
		["2 Player Match", 
			["2 Player",
				["to 3", func()->void: self.start_match(2, 3)], 
				["to 5", func()->void: self.start_match(2, 5)], 
				["to 10", func()->void: self.start_match(2, 10)]
			]
		],
		["Controls", func()->void: self.show_controls()],
		"Quit"
	]
	button_class = load("res://UI/MenuButton.tscn")
	
func start_match(players:int, goals:int)->void:
	SceneManager.change_scene(
		"res://Arena/arena.tscn", 
		EventManager.start_new_match, 
		[players, goals]
	)
	
func show_controls()->void:
	%buttons.visible = false
	%buttons.focus_mode = FOCUS_NONE
	%ControlsPanel.visible = true
	%ControlsBackButton.focus_mode = FOCUS_ALL
	%ControlsBackButton.grab_focus()

func Quit()->void:
	get_tree().quit()
