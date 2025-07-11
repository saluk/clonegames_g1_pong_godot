extends RigidBody2D

@export var launch_speed := 50.0
@export var min_velocity := 25.0
@export var min_x_velocity := 25.0
@export var max_velocity := 200.0

var detect_score := true

func _ready():
	EventManager.reset_ball.connect(
		func():
			move_to_center()
			detect_score = true
	)
	body_entered.connect(detect_hit)
	%movement.finished.connect(movement_sound)
	movement_sound()
	
func _process(dt:float)->void:
	%movement.volume_db = linear_velocity.length() / 100.0 * 2.0 + randf_range(-12.0, -8.0)
	%movement.pitch_scale = linear_velocity.length() / 100.0 * 1.0 + randf_range(0.0, 0.4)
	
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
	if linear_velocity.length() >= max_velocity:
		modulate.g = 0.0
		modulate.b = 0.0
	else:
		modulate.g = 1.0
		modulate.b = 1.0
		
#func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	if linear_velocity.length() > max_velocity:
		apply_impulse(-linear_velocity + linear_velocity.normalized()*max_velocity)
	if abs(linear_velocity.x) < min_x_velocity:
		apply_impulse(Vector2(linear_velocity.x,0))
	if linear_velocity.length() < min_velocity:
		apply_impulse(-linear_velocity + linear_velocity.normalized()*min_velocity)
		
func detect_hit(body) -> void:
	if body is Paddle:
		%blip7.play()
		body.show_bounce_glow()
	else:
		%blip7wall.play()
		
func launch() -> void:
	apply_central_impulse(Vector2(0,1).rotated(deg_to_rad(randf_range(45,120))) * launch_speed * randi_range(-1,1))

func movement_sound() -> void:
	var wait:float = randf_range(0.0, 0.05)
	await get_tree().create_timer(wait).timeout
	%movement.play()
