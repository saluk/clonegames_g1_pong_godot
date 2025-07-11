extends Node2D
class_name LineNode

signal tween_finished

#func _ready():
	#set_line(Vector2(0,0), Vector2(100, 50))
	#tween_line(Vector2(100, 50), Vector2(50, 80), 1.0)

func set_line(start:Vector2, end:Vector2) -> void:
	position = start
	scale.x = (end-start).length()
	rotation = (end-start).angle()
	
func tween_line(start:Vector2, end:Vector2, duration:float) -> void:
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_SPRING)
	# Tween position to start
	tween.tween_property(self, "position", start, duration)
	# Tween scale

	tween.parallel().tween_property(self, "scale", Vector2((end-start).length(), scale.y), duration)
	# Tween rotation
	tween.parallel().tween_property(self, "rotation", (end-start).angle(), duration)
	await tween.finished
	tween_finished.emit()
