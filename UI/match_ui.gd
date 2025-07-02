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
	var l:Label = Label.new()
	l.text = str(value)
	anims.add_child(l)
	l.position = Vector2(75,0)
	var d:Vector2 = score_ob.global_position - l.global_position
	while d.length() > 1:
		await get_tree().process_frame
		d = score_ob.global_position - l.global_position
		l.global_position += d.normalized()*get_process_delta_time()*100
	score_ob.text = str(value)
	anims.remove_child(l)

func show_win(player:int):
	win.text = "Player "+str(player+1)+" won! [R] to restart"
	win.visible = true
	win.get_child(0).emitting = true
