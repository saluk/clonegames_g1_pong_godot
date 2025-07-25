extends Node
class_name L

# TODO args can be moved to ...args in godot 4.5
static func log(args):
	var message = T.get_elapsed_time_string()+"\t"
	if args is Array:
		for a in args:
			message += str(a)
	else:
		message += str(args)
	print(message)
