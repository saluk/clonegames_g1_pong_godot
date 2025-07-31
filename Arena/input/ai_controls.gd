extends PaddleController

@onready var parent:AnimatableBody2D = get_parent()
@onready var collisionshape:CollisionShape2D = parent.get_node("CollisionShape2D")

# TODO move properties to paddle.gd
@export var player:String = "P1"
@export var speed := 100.0
@export var rotation_speed := 4.0
@export var max_rotation := 1.0
@export var min_y := -28
@export var max_y := 28

# AI props
@export var prepare_to_launch_dist := 10.0
@export var launch_dist := 5.0

@export var rotation_lerp_weight := 0.3

var rotation := 0.0
var target_rotation := max_rotation

var is_touched := false

func toggle_rotation()->void:
	if target_rotation > 0:
		target_rotation = -max_rotation
	elif target_rotation < 0:
		target_rotation = max_rotation

# Rerouted _physics_process
func controller_physics(dt: float) -> void:
	var move_vel:Vector2 = Vector2(0,0)
	
	var should_toggle_rot := false
	
	# IF - the ball is close enough, determine the ideal launch for the ball
	# if the ideal launch has not already happened, toggle rotation
	
	
	var ball:RigidBody2D = get_tree().get_first_node_in_group("ball")
	var target_y:float = ball.position.y
	# +y velocity, +rot; -y velocity, -rot
	var target_launch:int = int(ball.linear_velocity.y/ball.linear_velocity.y)
	# we should be at -target_launch if ball is > 10 pixels away, and target_launch
	# if ball is < 5 pixels away
	if abs(ball.position.x - parent.position.x) > prepare_to_launch_dist:
		if int(rotation/rotation) == target_launch:
			should_toggle_rot = true
	if abs(ball.position.x - parent.position.x) < launch_dist:
		if int(rotation/rotation) != target_launch:
			should_toggle_rot = true
		
	
	if should_toggle_rot:
		toggle_rotation()
		
	rotation = lerp(rotation, target_rotation, rotation_lerp_weight)

	if target_y < parent.position.y:
		move_vel.y -= speed * dt
	if target_y > parent.position.y:
		move_vel.y += speed * dt

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
