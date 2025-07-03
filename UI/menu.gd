extends Control
class_name Menu

@onready var buttons = %buttons
@onready var menu_title = %MenuTitle

var menu_data:Array
var button_class = Button
var stack:Array

func _init() -> void:
	init_data()
	stack.append(menu_data)

func init_data() -> void:
	menu_data = [
		"test1",
		"test2"
	]

func init_menu() -> void:
	N.empty(buttons)
	var data:Array = stack[-1]
	menu_title.text = data[0]
	for item in data.slice(1):
		var button:Button
		if button_class is PackedScene:
			button = button_class.instantiate()
		else:
			button = button_class.new()

		var button_text
		var method_name
		var submenu
		if item is String:
			button_text = item
			method_name = item
		elif item is Array:
			button_text = item[0]
			if item[1] is String:
				method_name = item[1]
			else:
				submenu = item[1]

		button.text = button_text
		if method_name:
			if has_method(method_name):
				button.pressed.connect(func(): call(method_name))
		elif submenu:
			button.pressed.connect(func(): 
				var new_menu = []
				new_menu.append(submenu[0])
				new_menu.append(["<", "prev_menu"])
				for subitem in submenu.slice(1):
					new_menu.append(subitem)
				stack.append(new_menu)
				init_menu()
			)
		buttons.add_child(button)
	buttons.get_child(0).grab_focus()

func _ready() -> void:
	init_menu()
	
func prev_menu() -> void:
	if len(stack) > 1:
		stack.remove_at(len(stack)-1)
		init_menu()
