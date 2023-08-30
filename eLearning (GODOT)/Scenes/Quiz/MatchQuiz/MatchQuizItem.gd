extends HBoxContainer
class_name MatchQuizItem

@export
var button: Button

@onready
var anchor := $CheckBox/Anchor

var used: bool = false
var key


func initialize(key, label: String) -> void:
	print(key)
	key = key
	$Label.text = label
