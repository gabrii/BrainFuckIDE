extends Timer


onready var interpreter = get_parent()

func _set_speed(s):
	if s == 0:
		interpreter.fast = true
	else:
		wait_time = s
		interpreter.fast = false
		