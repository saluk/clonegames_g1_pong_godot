extends Control

@onready var scores = [
	get_tree().get_first_node_in_group("player1score"),
	get_tree().get_first_node_in_group("player2score")
]
@onready var anims = get_tree().get_first_node_in_group("anims")
@onready var win = get_tree().get_first_node_in_group("win")

func _ready() -> void:
	EventManager.score_update.connect(update_scores)
	EventManager.game_won.connect(show_win)

func update_scores(score_values):
	for i in range(len(score_values)):
		if scores[i].text != str(score_values[i]):
			update_score(scores[i], score_values[i])
			
func update_score(score_ob:Label, value:int):
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
	win.text = "Player "+str(player+1)+" won!"
	win.visible = true
	win.get_child(0).emitting = true
	var match_end_menu = load("res://UI/MatchEndMenu.tscn").instantiate()
	add_child(match_end_menu)
