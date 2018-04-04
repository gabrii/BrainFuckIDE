extends TextEdit

export (int) var line_height = 20
export (int) var max_lines = 20

func _ready():
	connect("text_changed", self, "_on_text_changed")

func _on_text_changed():
	var lines = len(text.split('\n'))
	cursor_set_line (lines-1, true)
	lines = max(1, lines)
	lines = min(lines, max_lines)
	if lines == 1 and len(text) > 60:
		lines = 2
	rect_min_size.y = lines * line_height