extends Node
class_name N

static func empty(n:Node):
	for child in n.get_children():
		n.remove_child(child)
