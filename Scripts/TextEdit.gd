extends TextEdit



func _ready():
	# Based on Monokai Theme
	clear_colors ()
	add_keyword_color ("[", Color("#66d9ef"))
	add_keyword_color ("]", Color("#66d9ef"))
	add_keyword_color ("<", Color("#ae81ff"))
	add_keyword_color (">", Color("#ae81ff"))
	add_keyword_color ("-", Color("#f92672"))
	add_keyword_color ("+", Color("#a6e22e"))
	add_keyword_color (".", Color("#fd971f"))
	add_keyword_color (",", Color("#fd971f"))

func _type(s):
	insert_text_at_cursor(s)
	grab_focus()


func show_keyboard():
	OS.show_virtual_keyboard()
