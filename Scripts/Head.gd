extends TextureRect

export(int) var x_offset = -16
export(int) var cell_width = 64
export(float) var animation_speed = 0.5

var dt = 0.0
var current_cell = 0
var target_cell = null

onready var cells_container = get_parent()

onready var vc = get_node("/root/CanvasLayer/ViewportControl")

func _ready():
	#set_process(true)
	move_to_cell(current_cell)
	

func _process(delta):
	if target_cell != null:
		dt += delta
		if dt > animation_speed:
			move_to_cell(target_cell)
			current_cell = target_cell
			target_cell = null
		else:
			move_to_cell(lerp(current_cell, target_cell, dt / animation_speed))


func move_to_cell(cell_index):
	rect_position.x = x_offset + cell_index * cell_width
	var x = get_global_rect().position.x
	if x + 64 > vc.width:
		cells_container.margin_left -= x + 64 - vc.width
	elif x < 0:
		cells_container.margin_left += -x

func smooth_move_to_cell(cell):
	dt = 0
	if target_cell != null:
		current_cell = target_cell
	target_cell = cell