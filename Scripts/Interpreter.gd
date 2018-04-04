extends Node
const bf_chars = "+-><.,[]"
export(bool) var fast = false
export(bool) var optimized = true
export(int) var cell_count = 128
var cells  # []
var script # []
var breakpoints = []
const path = "/root/CanvasLayer/VBoxContainer/"
onready var text_edit  = get_node(path + "TextEdit")
onready var input_node  = get_node(path + "Input")
onready var output_node  = get_node(path + "Output")
onready var cells_node = get_node(path + "Container/TextureRect/Cells")
onready var head = get_node(path + "Container/Head")
onready var timer = get_node("Timer")

onready var buttons = get_node("../HBoxContainer")

var input_i = 0
var paused = false
var running = false
var skip_breakpoints = false setget set_skip_breakpoints

var lookup_dict = Dictionary()

func set_skip_breakpoints(button_pressed):
	skip_breakpoints = !button_pressed

func _ready():
	head.animation_speed = timer.wait_time * 0.75
	set_process(true)
	for i in range(128):
		lookup_dict[char(i)] = i

func _tick():
	if running and !paused:
		step()


func _process(delta):
	if fast:
		var i = 0
		while i < 1000 and running and !paused:
			step()
			i+=1
	
			
func step():
	if running == false:
		run()
		pause()
	else:
		running = cycle()
	if !running:
		halt()

func halt():
	buttons.set_state(buttons.STOPED)
	text_edit.caret_blink = true
	text_edit.deselect()

func load_example(example):
	stop()
	
	buttons.set_state(buttons.STOPED)
	input_node.text = example.input
	text_edit.text = example.code
	init_cells()
	
func init_cells():
	cells = []
	cells_node.idle_all_cells()
	for i in range(cell_count):
		cells.append(0)
		
func pause():
	paused = true
	text_edit.caret_blink = true
	text_edit.deselect()

func resume():
	paused = false
	text_edit.caret_blink = false

func run():
	
	if running == true:
		stop()
	paused = false
	_run()
	running = cycle()
	
	text_edit.caret_blink = false


var i
var op_i
var max_i
var op
var last_row

func _run():
	input_i = 0
	parse_script()
	init_cells()
	output_node.text = ""
	i = 0
	op_i = 0
	max_i = len(script) -1

func cycle():
	var ofast = fast
	fast = false
	if op_i == -1:
		return false
	
	op = script[op_i]
	if op[0] != '[':
		op_i = op[3]
	
	if !fast:
		text_edit.cursor_set_column(op[2])
		text_edit.grab_focus()
	if op[1] != last_row:
		last_row = op[1]
		if !fast:
			text_edit.cursor_set_line(op[1])
		if !skip_breakpoints and last_row in breakpoints:
			pause()
			buttons.set_state(buttons.PAUSED)
			
		
	match op[0]:
		'+':
			cells[i] += op[4]
			
			if  i < cell_count and !fast:
				cells_node.cells[i].value = cells[i]
		'-':
			cells[i] -= op[4]
			
			if i < cell_count and !fast:
				cells_node.cells[i].value = cells[i]
				
		'[':
			if cells[i] != 0:
				if !fast:
					text_edit.select(op[1], op[2], script[op[3]][1], script[op[3]][2])
				op_i +=1
			else:
				op_i = op[3] 
				if !fast:
					text_edit.deselect()
		'>':
			i += op[4]
			while len(cells) <= i:
				cells.append(0) 
				
			if i < cell_count:
				if !fast:
					head.smooth_move_to_cell(i)
				elif false:
					head.move_to_cell(i)
		'<':
			i -= op[4]
			if i < cell_count:
				if !fast:
					head.smooth_move_to_cell(i)
				elif false:
					head.move_to_cell(i)
		'.':
			var v = cells[i]
			for j in op[4]:
				if v >= 10 and v < 127:
					output_node.text += str(char(v))
				else:
					output_node.text += (" %d" % v) * op[4]
		',':
			
			for j in op[4]:
				if input_i < len(input_node.text):
					cells[i] = input_node.text[input_i].to_ascii()[0]
					input_i += 1
				else:
					cells[i] = 0
				if i < cell_count:
					cells_node.cells[i].value = cells[i]
		_:
			pass
	
	fast = ofast
	return true

func _on_set_breakpoint(line):
	if line in breakpoints:
		breakpoints.erase(line)
	else:
		breakpoints.append(line)

func stop():
	running = false
	text_edit.caret_blink = true
	text_edit.deselect()
	
func parse_script():
	script = []
	var op_i = 0
	var row_i = 0
	var col_i = 0
	var last_col = null
	var loop_stack = []
	var loop_start = null
	for row in text_edit.text.split('\n'):
		col_i = 0
		for col in row:
			if col in bf_chars:
				if col == '[':
					loop_stack.push_front(op_i)

				if optimized and last_col == col and col != "[" and col != "]":
					script[-1][4] += 1
				else:
					last_col = col
					var next_op
					if col == ']':
						loop_start = loop_stack.pop_front()
						script[loop_start][3] = op_i+1
						next_op = loop_start
					else:
						next_op = op_i + 1
					script.append(
						[col, row_i, col_i, next_op, 1]
					)
					op_i += 1
			col_i += 1
		row_i += 1 
	if last_col == "]":
		script[loop_start][3] = -1
	elif len(script):
		script[-1][3] = -1



func _on_set_optimize(optimize):
	optimized = optimize
	if running:
		run()
		buttons.set_state(buttons.RUNNING)
	print(optimize)

	
