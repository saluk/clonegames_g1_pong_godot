extends Node2D
class_name LineArt

var line_data:Array[Array] = []
var lineNode:PackedScene = load("res://Effects/LineNode.tscn")

func _ready():
	line_data = [
		[Vector2(2,0), Vector2(20,0)],
		[Vector2(20,0), Vector2(20,30)],
		[Vector2(2,0), Vector2(2,30)],
		[Vector2(2,10), Vector2(20,10)]
	]
	tween_lines(line_data, 1.5)
	
func tween_lines(new_line_data:Array[Array], duration:float) -> void:
	# If we need to add or remove lines to children, do so so that
	while get_child_count() < len(new_line_data):
		add_line_node()
	while get_child_count() > len(new_line_data):
		remove_line_node()
	# the length of our lines matches the new line data
	
	# deleted lines can fly away
	# added lines can come in from the edge
	
	
	# for each LineNode in our children, tween them from line_data[i] to new_line_data[i]
	var child:LineNode
	for i in range(get_child_count()):
		child = get_child(i)
		child.tween_line(line_data[i][0], line_data[i][1], duration)
		
	# wait for lines to finish tweening
	for i in range(get_child_count()):
		child = get_child(i)
		await child.tween_finished

func add_line_node() -> void:
	var ln:LineNode = lineNode.instantiate()
	var start := Vector2(1, 0).rotated(randf_range(0.0,359.0)) * randi_range(100,200) + Vector2(100,50)
	add_child(ln)
	ln.set_line(start, start.rotated(randf_range(0.0, 359.0)) * randi_range(5,50))
	
func remove_line_node() -> void:
	remove_child(get_child(0))
