extends RigidBody2D

@export var launch_speed := 1.0
@export var min_velocity := 25.0
@export var min_x_velocity := 10.0
@export var max_velocity := 100.0

var detect_score := true

func _ready():
	EventManager.reset_ball.connect(
		func():
			move_to_center()
			detect_score = true
	)
	
func move_to_center():
	position = Vector2(0,0)
	linear_velocity = Vector2(0,0)
	var rid = get_rid()
	PhysicsServer2D.body_set_state(rid, PhysicsServer2D.BODY_STATE_TRANSFORM, get_transform())

func _physics_process(dt: float) -> void:
	if linear_velocity.is_zero_approx():
		launch()
	if detect_score and (position.x < -70 or position.x > 70):
		detect_score = false
		EventManager.ball_off_screen.emit(position.x)
		
func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	if linear_velocity.length() > max_velocity:
		apply_impulse(-linear_velocity + linear_velocity.normalized()*max_velocity)
	if abs(linear_velocity.x) < min_x_velocity:
		apply_impulse(Vector2(linear_velocity.x,0))
	if linear_velocity.length() < min_velocity:
		apply_impulse(-linear_velocity + linear_velocity.normalized()*min_velocity)
		
func launch():
	apply_central_impulse(Vector2(0,1).rotated(randf_range(0,359)) * launch_speed)
