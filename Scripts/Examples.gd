extends Panel

var examples = []
onready var container = get_node("VBoxContainer")
onready var interpreter = get_node("../Interpreter")

func _ready():
	load_examples()

func load_examples():
	for node in get_children():
		if node.get_class() == 'Node':
			var instance = Button.new()
			instance.set_name(node.name)
			instance.set_text(node.name)
			instance.connect("pressed", interpreter, "load_example", [node]) 
			instance.connect("pressed", self, "hide")
			instance.rect_min_size.y = 32
			instance.theme = theme
			container.add_child(instance)
			examples.append(instance)


func _on_click_examples():
	visible = !visible

