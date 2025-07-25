extends Node

func change_scene(scene:String, sig:Signal, args:Array) -> void:
	get_tree().change_scene_to_file(scene)
	await get_tree().process_frame
	await get_tree().process_frame
	sig.emit.callv(args)
