extends Node2D

@export var move_speed :=  10
@export var grow_speed := 5
@export var fade_speed := -2

func _process(delta: float) -> void:
	position.x += move_speed * delta
	scale.x = scale.x + grow_speed * delta
	scale.y = scale.y + grow_speed * delta
	modulate.a += fade_speed * delta
