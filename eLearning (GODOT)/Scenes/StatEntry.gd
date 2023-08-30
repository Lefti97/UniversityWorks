extends HBoxContainer

@export
var title_node: Label
@export
var value_node: Label


func set_data(title: String, value: String) -> void:
	title_node.text = title
	value_node.text = value
