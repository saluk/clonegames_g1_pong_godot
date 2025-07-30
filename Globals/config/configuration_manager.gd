extends Node

@export var _configuration:ConfigurationResource

var run_on_changed:Array[Callable] = []

func _ready() -> void:
	SceneManager.scene_changed.connect(func(_scene:String, _sig:Signal, _args:Array)->void:
		trigger_updates()
	)
	run_on_changed += [
		toggle_debug
	]
	trigger_updates()
	
func trigger_updates()->void:
	for f:Callable in run_on_changed:
		f.call()
	
func set_config_value(key:String, value:Object)->void:
	_configuration.set(key, value)
	
@warning_ignore("untyped_declaration")
func get_config_value(key:String):
	return _configuration.get(key)
		
func toggle_debug() -> void:
	for debug_object:CanvasItem in EventManager.get_tree().get_nodes_in_group("debug_object"):
		debug_object.visible = _configuration.show_debug
