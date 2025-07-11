extends AnimatableBody2D
class_name Paddle

func show_bounce_glow():
	var n:Node2D = get_node("BounceGlow")
	n.modulate.a = 1.0
	n.position = Vector2(0,0)
	n.scale = Vector2(1.0, 1.0)
	n.visible = true
	n.set_process(true)
	await get_tree().create_timer(1.0).timeout
	n.visible = false
	n.set_process(false)
