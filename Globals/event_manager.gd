# Create global signals here

extends Node

# Matches/ai
signal start_new_match(players, goals)
signal enable_ai
signal disable_ai

# Game state
signal ball_off_screen(xpos)
signal reset_ball
signal rematch
signal pause_match
signal resume_match

# Score
signal score_update(scores)
signal game_won(player)
