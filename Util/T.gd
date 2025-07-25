extends Node
class_name T

static func get_elapsed_time_string(msec=null) -> String:
	if msec == null:
		msec = Time.get_ticks_msec()
	var msec_actual = msec % 1000
	var seconds = (msec/1000)%60
	var minutes = (msec/1000)/60%60
	var hours = (msec/1000)/60/60%24
	return "%02d:%02d:%02d:%02d" % [hours, minutes, seconds, msec_actual]
