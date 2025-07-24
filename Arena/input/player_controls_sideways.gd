extends PaddleController

@export var label:String

@onready var parent:AnimatableBody2D = get_parent()
@onready var collisionshape:CollisionShape2D = parent.get_node("CollisionShape2D")

# TODO move properties to paddle.gd
@export var player:String = "P1"
@export var speed := 100.0
@export var rotation_speed := 4.0
@export var max_rotation := 1.0
@export var min_y := -28
@export var max_y := 28

@onready var startx = parent.position.x
@export var max_x_variation = 50

var rotation := 0.0
var is_touched = false
var mouse_move = Vector2()

func _input(event: InputEvent) -> void:
	Recordings.add_input_event(event)
	if event is InputEventMouseButton:
		var click_pos:Vector2 = get_viewport().get_canvas_transform().affine_inverse() * event.position
		var rect := collisionshape.shape.get_rect().grow(10)
		rect.position += parent.global_position
		# offset for camera
		if event.pressed and rect.has_point(click_pos):
			is_touched = true
		if not event.pressed:
			is_touched = false
	if event is InputEventMouseMotion:
		if is_touched:
			mouse_move = event.screen_relative / get_viewport().get_canvas_transform().get_scale()

func _physics_process(dt: float) -> void:
	var move_vel:Vector2 = Vector2(0,0)+Vector2(0,mouse_move.y)
	
	if Input.is_action_pressed(player + " right"):
		move_vel.x += speed * dt
	elif Input.is_action_pressed(player + " left"):
		move_vel.x -= speed * dt

	if Input.is_action_pressed(player + " up"):
		move_vel.y -= speed * dt
	if Input.is_action_pressed(player + " down"):
		move_vel.y += speed * dt

	var new_pos = parent.position+move_vel
	if new_pos.y > max_y:
		new_pos.y = max_y
	if new_pos.y < min_y:
		new_pos.y = min_y
	
	if startx > 0:
		if new_pos.x < startx-max_x_variation:
			new_pos.x = startx-max_x_variation
		if new_pos.x > startx:
			new_pos.x = startx
	else:
		if new_pos.x > startx+max_x_variation:
			new_pos.x = startx+max_x_variation
		if new_pos.x < startx:
			new_pos.x = startx
	var transform := Transform2D(rotation, new_pos)
	parent.transform = transform
	parent.get_node("GFX").global_rotation = int(rotation*3.0)/3.0
	

	mouse_move = Vector2()
