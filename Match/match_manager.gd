extends Node

var score:Array[int] = [0, 0]
@export var play_to_points := 3
var is_won := false

func _ready() -> void:
	EventManager.start_new_match.connect(start_new_match)
	EventManager.score_update.emit(score)
	EventManager.ball_off_screen.connect(player_scored)
	EventManager.rematch.connect(rematch)
	
func start_new_match(players:int, goals:int)->void:
	if players == 1:
		EventManager.enable_ai.emit()
	else:
		EventManager.disable_ai.emit()
	play_to_points = goals
	
func player_scored(xpos:float) -> void:
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

func add_score(player:int) -> void:
	score[player] += 1
	EventManager.score_update.emit(score)
	if score[player] >= play_to_points:
		is_won = true
		winsounds()
		get_tree().paused = true
		EventManager.game_won.emit(player)
		
func winsounds() -> void:
	%goodwin.play()
	%badwin.play()

func rematch() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()
