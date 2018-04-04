extends Node


onready var interpreter = get_node("../Interpreter")
onready var keyboard = get_node("../GridContainer")
var buttons 


enum {STOPED, RUNNING, PAUSED}
var state = STOPED setget set_state
var states = [
	[ 
		"STEP", PAUSED,
		"", null,
		"RUN", RUNNING,
	],
	[ 
		"", null,
		"PAUSE", PAUSED,
		"STOP", STOPED,
	],
	[
		"STEP", PAUSED,
		"RESUME", RUNNING,
		"STOP", STOPED,
	],
]

func _ready():
	buttons = get_children()
	buttons.pop_front()
	var i = 0
	for button in buttons:
		button.connect("pressed", self, "_on_button_pressed", [i])
		i += 1
	update_labels()

func update_labels():
	for i in range(len(buttons)):
		buttons[i].text = states[state][i*2] 

func set_state(s):
	state = s
	update_labels()

func _on_button_pressed(button):
	var order = states[state][button*2]
	if order in ["RUN", "RESUME", "STEP"]:
		keyboard.hide()
	if order != "":
		interpreter.call(order.to_lower())
		set_state(states[state][button*2 + 1])
		
