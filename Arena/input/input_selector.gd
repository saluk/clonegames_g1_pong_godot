extends Node
class_name InputSelector

@export var player = "P1"
@onready var label = %InputLabel

var inputs:Array[PaddleController]
var disabled_inputs:Array[PaddleController]

var is_ai_enabled = false

@export var current_mode:PaddleController:
	set(v):
		current_mode = v
		disable()
		enable()

func disable():
	for input_mode in inputs+disabled_inputs:
		if input_mode in get_parent().get_children():
			get_parent().remove_child.call_deferred(input_mode)
			
func enable():
	if current_mode in inputs:
		get_parent().add_child.call_deferred(current_mode)
		current_mode.player = player
		
func _ready():
	if player == "P2":
		EventManager.enable_ai.connect(enable_ai)
		EventManager.disable_ai.connect(disable_ai)
	inputs.assign(N.get_typed_children(get_parent(), PaddleController))
	if is_ai_enabled:
		enable_ai()
	else:
		disable_ai()
	disable()
	enable()
	
func enable_ai() -> void:
	var new_inputs:Array[PaddleController] = []
	var new_input_disable:Array[PaddleController] = []
	for inp in inputs+disabled_inputs:
		print(inp)
		print(inp.is_ai)
		if not inp.is_ai:
			new_input_disable.append(inp)
		else:
			new_inputs.append(inp)
	inputs = new_inputs
	disabled_inputs = new_input_disable
	current_mode = inputs[0]
	disable()
	enable()
	
func disable_ai() -> void:
	var new_inputs:Array[PaddleController] = []
	var new_input_disable:Array[PaddleController] = []
	for inp in inputs+disabled_inputs:
		if inp.is_ai:
			new_input_disable.append(inp)
		else:
			new_inputs.append(inp)
	inputs = new_inputs
	disabled_inputs = new_input_disable
	current_mode = inputs[0]
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
