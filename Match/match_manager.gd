extends Node

var score:Array[int] = [0, 0]
@export var play_to_points := 3
var is_won = false

func _ready():
	EventManager.score_update.emit(score)
	EventManager.ball_off_screen.connect(player_scored)
	
func player_scored(xpos):
	var player:int = 0 if xpos > 0 else 1
	add_score(player)
	var t:Timer = Timer.new()
	t.wait_time = 2
	t.autostart = true
	add_child(t)
	await t.timeout
	remove_child(t)
	if not is_won:
		EventManager.reset_ball.emit()

func add_score(player):
	score[player] += 1
	EventManager.score_update.emit(score)
	if score[player] >= play_to_points:
		is_won = true
		get_tree().paused = true
		EventManager.game_won.emit(player)
