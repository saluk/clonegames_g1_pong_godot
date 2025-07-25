# Create global signals here
@warning_ignore_start("unused_signal")

extends Node

# Matches/ai
signal start_new_match(players:int, goals:int)
signal enable_ai
signal disable_ai

# Game state
signal ball_off_screen(xpos:int)
signal reset_ball
signal rematch
signal pause_match
signal resume_match

# Score
signal score_update(scores:Array)
signal game_won(player:int)
