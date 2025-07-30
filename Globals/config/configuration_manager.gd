extends Node

@export var _configuration:ConfigurationResource

var run_on_changed:Array[Callable] = []

func _ready() -> void:
	SceneManager.scene_changed.connect(func(scene:String, sig:Signal, args:Array):
		trigger_updates()
	)
	run_on_changed += [
		toggle_debug
	]
	trigger_updates()
	
func trigger_updates():
	for f:Callable in run_on_changed:
		f.call()
	
func set_config_value(key:String, value:Object):
	_configuration.set(key, value)
	
func get_config_value(key:String):
	return _configuration.get(key)
		
func toggle_debug() -> void:
	for debug_object:CanvasItem in EventManager.get_tree().get_nodes_in_group("debug_object"):
		debug_object.visible = _configuration.show_debug
