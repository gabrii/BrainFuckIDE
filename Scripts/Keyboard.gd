extends GridContainer

onready var container = get_node("../VBoxContainer")
onready var interpreter = get_node("../Interpreter")
var quits = 1

func _ready():
	get_tree().set_auto_accept_quit(false)

func _update():
	if visible:
		container.margin_bottom = - rect_size.y - 16
	else:
		container.margin_bottom = -16

func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST or what == MainLoop.NOTIFICATION_WM_GO_BACK_REQUEST:
		if visible:
			hide()
		else:
			if quits:
				quits-=1
			else:
				get_tree().quit()

func show_if_mobile():
	if OS.has_touchscreen_ui_hint():
		show()

func _cursor_changed():
	if interpreter.paused or !interpreter.running:
		show_if_mobile()

