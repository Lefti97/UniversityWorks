extends Control
class_name MultipleChoice

signal quiz_completed
signal quiz_failed

@export
var button_container: Control

@onready
var question_node: Label = get_node("%Label")

@onready
var answer_button_prefab: Button = get_node("%ButtonPrefab")

@onready
var next_button: Button = get_node("Next")

var question: String
var correct_answer: int
var choices: Array[String]


func _ready() -> void:
	next_button.visible = false


# Assumes data is a dictionary from QuizData
func initialize(data: Dictionary) -> void:
	question = data["question"]
	correct_answer = data["correct"]
	choices = data["choices"]

	question_node.text = question

	var index := 0
	for choice in choices:
		var btn = answer_button_prefab.duplicate()
		btn.name = str(index)
		btn.text = choice
		btn.visible = true
		btn.pressed.connect(func():
			if index == int(correct_answer) - 1:
				self.quiz_completed.emit()
			else:
				self.quiz_failed.emit()
				btn.add_theme_stylebox_override("disabled", get_style_wrong())
			next_button.visible = true
			disable_all_buttons()
			highlight_correct_button()
		)
		button_container.add_child(btn)
		index += 1


func disable_all_buttons() -> void:
	for child in button_container.get_children():
		child.disabled = true


func highlight_correct_button() -> void:
	button_container.get_node(str(correct_answer - 1)).add_theme_stylebox_override("disabled", get_style_correct())

func get_style_correct() -> StyleBoxFlat:
	var style = StyleBoxFlat.new()
	style.border_width_bottom = 2
	style.border_width_top = 2
	style.border_width_left = 2
	style.border_width_right = 2
	style.border_color = Color.GREEN
	return style


func get_style_wrong() -> StyleBoxFlat:
	var style = StyleBoxFlat.new()
	style.border_width_bottom = 2
	style.border_width_top = 2
	style.border_width_left = 2
	style.border_width_right = 2
	style.border_color = Color.RED
	return style
