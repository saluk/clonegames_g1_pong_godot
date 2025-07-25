extends Node

@onready var parent:Camera2D = get_parent()
var cycle := 0.0


func _process(dt:float)->void:
	cycle += dt
	parent.rotation_degrees = sin(cycle*2.0)*10.0
	parent.zoom.x = (sin(cycle*1.5+1.5)+1.0)*0.5+0.5
	parent.zoom.y = parent.zoom.x
