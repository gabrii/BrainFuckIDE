extends Node

onready var viewport = get_viewport()
onready var container = get_node("../VBoxContainer")

var width = INF
var minimum_size = 700
var resizing = true

func _ready():
	viewport.connect("size_changed", self, "window_resize")
	
	if not OS.has_touchscreen_ui_hint():
		minimum_size = 1024
		resizing = false
		ProjectSettings.set_setting("display/window/stretch/mode", 0)
		ProjectSettings.set_setting("display/window/stretch/aspect", 1)
		OS.set_window_maximized(true)
	window_resize()

func window_resize():
	if resizing:
		var current_size = OS.get_window_size()
		var scale_factor
		var new_size
		if current_size.x < current_size.y:
			scale_factor = minimum_size/current_size.x
			new_size = Vector2(minimum_size, current_size.y*scale_factor)
		else:
			scale_factor = minimum_size/current_size.y
			new_size = Vector2(current_size.x*scale_factor, minimum_size)
			
		if scale_factor < 1:
			container.margin_left = 16
			container.margin_top = 64
			container.margin_right = -16
			container.margin_bottom = -16
		else:
			container.margin_left = 50
			container.margin_top = 96
			container.margin_right = -50
			container.margin_bottom = 0
			
		width = new_size.x
		viewport.set_size_override(true, new_size)
