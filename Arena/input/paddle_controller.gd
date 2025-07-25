extends Node
class_name PaddleController
@export var label:String
@export var is_ai:bool
@export var is_enabled:bool = true  # Determine whether this controller CAN be selected

var is_currently_active:bool = false

func _input(event:InputEvent) -> void:
	if is_currently_active:
		controller_input(event)
	
func _physics_process(dt:float) -> void:
	if is_currently_active:
		controller_physics(dt)
	
func controller_input(_event:InputEvent) -> void:
	pass
	
func controller_physics(_dt:float) -> void:
	pass
