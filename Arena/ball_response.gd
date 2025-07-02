extends Node

@onready var parent:RigidBody2D = get_parent()

func _ready():
	parent.body_entered.connect(response)
	
func response(body):
	# Currently just paddles
	if body is CharacterBody2D:
		parent.linear_velocity = -parent.linear_velocity
