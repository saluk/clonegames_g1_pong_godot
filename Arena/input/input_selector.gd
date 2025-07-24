extends Node
class_name InputSelector

@export var player = "P1"
@onready var label = %InputLabel

var inputs:Array[PaddleController]
@export var current_mode:PaddleController:
	set(v):
		current_mode = v
		disable()
		enable()

func disable():
	for input_mode in inputs:
		if input_mode in get_parent().get_children():
			get_parent().remove_child.call_deferred(input_mode)
			
func enable():
	if current_mode in inputs:
		get_parent().add_child.call_deferred(current_mode)
		current_mode.player = player
		
func _ready():
	inputs.assign(N.get_typed_children(get_parent(), PaddleController))
	disable()
	enable()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed(player+" switch input mode"):
		var i = inputs.find(current_mode)
		i += 1
		if i>=len(inputs):
			i = 0
		current_mode = inputs[i]
		
func _process(dt):
	label.set_text(current_mode.label)
	label.position = get_parent().position
	if player == "P1":
		label.position -= Vector2(10,0)
	else:
		label.position += Vector2(3,0)
