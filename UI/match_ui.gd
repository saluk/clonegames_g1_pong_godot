extends Control

@onready var scores = [
	get_tree().get_first_node_in_group("player1score"),
	get_tree().get_first_node_in_group("player2score")
]
@onready var anims = get_tree().get_first_node_in_group("anims")
@onready var win = get_tree().get_first_node_in_group("win")

var pause_menu_ui = null

func _ready() -> void:
	EventManager.score_update.connect(update_scores)
	EventManager.game_won.connect(show_win)
	EventManager.pause_match.connect(pause_menu)
	EventManager.resume_match.connect(resume_match)

func update_scores(score_values):
	for i in range(len(score_values)):
		if scores[i].text != str(score_values[i]):
			update_score(scores[i], score_values[i])
			
func update_score(score_ob:Label, value:int):
	score_ob.get_child(0).play()
	var old_text = score_ob.text
	score_ob.text = str(value)
	var t:Timer = Timer.new()
	t.wait_time = 0.5
	t.one_shot = true
	var l:Label = Label.new()
	l.text = old_text
	anims.add_child(l)
	anims.add_child(t)
	t.start()
	l.global_position = score_ob.global_position
	var launch_dir = Vector2.from_angle(randf()*360) * randf_range(150,200)
	var angle_speed = randf_range(200, 400)
	while t.time_left:
		await get_tree().process_frame
		l.position += launch_dir * get_process_delta_time()
		l.rotation_degrees += angle_speed * get_process_delta_time()
	anims.remove_child(l)
	anims.remove_child(t)

func show_win(player:int):
	if pause_menu_ui:
		remove_child(pause_menu_ui)
	win.text = "Player "+str(player+1)+" won!"
	win.visible = true
	win.get_child(0).emitting = true
	pause_menu_ui = load("res://UI/MatchEndMenu.tscn").instantiate()
	add_child(pause_menu_ui)

func pause_menu() -> void:
	if not pause_menu_ui:
		get_tree().paused = true
		pause_menu_ui = load("res://UI/PauseMenu.tscn").instantiate()
		add_child(pause_menu_ui)

func resume_match() -> void:
	if pause_menu_ui:
		remove_child(pause_menu_ui)
		pause_menu_ui = null
		get_tree().paused = false
