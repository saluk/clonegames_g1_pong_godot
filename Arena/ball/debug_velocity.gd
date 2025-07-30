extends Line2D

@onready var parent:RigidBody2D = get_parent()
@onready var label:Label = get_node("Label")


func _process(_delta: float) -> void:
	points[1] = parent.linear_velocity*0.25
	global_rotation = 0
	label.text = str(parent.linear_velocity.length())
