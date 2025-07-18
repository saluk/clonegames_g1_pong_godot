extends Node
class_name N

static func empty(n:Node) -> void:
	for child in n.get_children():
		n.remove_child(child)

static func get_typed_children(n:Node, t) -> Array[Node]:
	var children:Array[Node] = []
	for c in n.get_children():
		if is_instance_of(c, t):
			children.append(c)
	return children
