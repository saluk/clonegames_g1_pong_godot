extends PaddleController

var MOVE_MODE := "other"

@onready var parent:AnimatableBody2D = get_parent()
@onready var collisionshape:CollisionShape2D = parent.get_node("CollisionShape2D")

# TODO move properties to paddle.gd
@export var player:String = "P1"
@export var speed := 100.0
@export var rotation_speed := 4.0
@export var max_rotation := 1.0
@export var min_y := -28
@export var max_y := 28

var rotation := 0.0
var is_touched := false
var mouse_move := Vector2()

# Rerouted _input
func controller_input(event: InputEvent) -> void:
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

# Rerouted _physics_process
func controller_physics(dt: float) -> void:
	var move_vel:Vector2 = Vector2(0,0)+Vector2(0,mouse_move.y)
		
	if is_touched:
		rotation += min(mouse_move.x * 0.1, 1.0)
	else:
		if Input.is_action_pressed(player + " right"):
			rotation += dt*rotation_speed
		elif Input.is_action_pressed(player + " left"):
			rotation -= dt*rotation_speed
		else:
			rotation = lerp(rotation, 0.0, 0.1)

	if Input.is_action_pressed(player + " up"):
		move_vel.y -= speed * dt
		if MOVE_MODE == "updown":
			rotation -= dt*rotation_speed *4
	if Input.is_action_pressed(player + " down"):
		move_vel.y += speed * dt
		if MOVE_MODE == "updown":
			rotation += dt*rotation_speed * 4

	if rotation > max_rotation:
		rotation = max_rotation
	if rotation < -max_rotation:
		rotation = -max_rotation

	var new_pos := parent.position+move_vel
	if new_pos.y > max_y:
		new_pos.y = max_y
	if new_pos.y < min_y:
		new_pos.y = min_y
	var transform := Transform2D(rotation, new_pos)
	parent.transform = transform
	parent.get_node("GFX").global_rotation = int(rotation*3.0)/3.0
	

	mouse_move = Vector2()
