extends HBoxContainer
export (int) var cells_count = 128
var cells
var cell_scene = preload("res://Scenes/Cell.tscn")




func _ready():
	for i in range(cells_count):
		var instance = cell_scene.instance()
		instance.set_name("Cell%d" % i)
		instance.index = i
		add_child(instance)
	cells = get_children()


func idle_all_cells():
	for cell in cells:
		cell.active = false