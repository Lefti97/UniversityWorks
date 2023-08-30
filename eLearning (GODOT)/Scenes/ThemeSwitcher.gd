extends CheckButton

@export
var light_theme: Theme
@export
var dark_theme: Theme

var dash: Control


func _ready() -> void:
	dash = get_tree().root.get_node("Dashboard")


func toggle_theme(pressed: bool) -> void:
	if pressed:
		dash.theme = dark_theme
	else:
		dash.theme = light_theme
