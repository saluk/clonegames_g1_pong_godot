# Assign to a node, and link the graphical objects into the copy_objects array
# On ready, will add a container of trailing objects who copy the position of the originals

extends Node2D
class_name MotionBlurComponent

@onready var parent:Node = get_parent()
@export var copy_object_path:NodePath
@export var trail_count:int = 1
@export var fade_amount:float = 0.9
@export var initial_scale_amount:float = 0.8
@export var scale_amount:float = 0.9
var copy_object:Node
@export var offset = 1

var prev_pos:Array[Vector2]
var prev_rot:Array[float]

func _ready() -> void:
	if not copy_object:
		copy_object = get_node(copy_object_path)
	var copy:Node = copy_object.duplicate()
	copy.modulate.r *= fade_amount
	copy.modulate.g *= fade_amount
	copy.modulate.b *= fade_amount
	copy.scale *= initial_scale_amount
	add_child(copy)
	if trail_count-1 > 0:
		var next = MotionBlurComponent.new()
		next.copy_object = copy
		next.trail_count = trail_count - 1
		next.offset = offset
		next.fade_amount = fade_amount
		next.initial_scale_amount = 1.0
		next.scale_amount = scale_amount
		add_child(next)
	
func _process(delta:float) -> void:
	prev_pos.insert(0, copy_object.global_position)
	prev_pos = prev_pos.slice(0,offset+1)
	prev_rot.insert(0, copy_object.global_rotation)
	prev_rot = prev_rot.slice(0,offset+1)
	var n:Node = get_child(0)
	if offset < len(prev_pos):
		call("copy_position", offset, n)
	else:
		call("copy_position", -1, n)

func copy_position(i:int, n:Node) -> void:
	n.global_position = prev_pos[i]
	n.global_rotation = prev_rot[i]
