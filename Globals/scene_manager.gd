extends Node

signal null_signal
signal scene_changed(scene:String, sig:Signal, args:Array)

# Change scenes and unpause the scene tree
func change_scene(scene:String, sig:Signal=null_signal, args:Array=[]) -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file(scene)
	await get_tree().process_frame
	await get_tree().process_frame
	sig.emit.callv(args)
	scene_changed.emit(scene, sig, args)
