extends AudioStreamPlayer2D
class_name AudioPlayerExtra

@export var loop:bool = false

func _ready() -> void:
	finished.connect(func()->void:
		if loop:
			play()
	)
