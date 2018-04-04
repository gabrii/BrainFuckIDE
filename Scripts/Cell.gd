extends Label

export(Color) var idle_color
export(Color) var active_color
export(bool) var active = true setget _set_active 
export(int) var value = 0 setget _set_value


var index_label = null
export(int) var index

func _set_active(a):
	if active != a:
		active = a
		set("custom_colors/font_color", active_color if active else idle_color)

func _set_value(v):
	_set_active(true)
	value = v
	text = str(v)

func _set_index(i):
	index = i
	if index_label == null:
		index_label = get_node("X")
	index_label.text = str(i)

func _ready():
	_set_active(false)
	_set_index(index)
