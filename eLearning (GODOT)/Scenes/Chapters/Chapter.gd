extends Control
class_name Chapter

signal chapter_completed

@export
var number := 0

var child_index := 0


func _ready() -> void:
	if get_child_count() > 0:
		get_child(0).visible = true


func next() -> void:
	if child_index >= total() - 1:
		return

	get_child(child_index).visible = false
	child_index += 1
	get_child(child_index).visible = true

	if child_index >= total() - 1:
		chapter_completed.emit()


func previous() -> void:
	if child_index <= 0:
		return
	get_child(child_index).visible = false
	child_index -= 1
	get_child(child_index).visible = true


func status() -> int:
	return child_index


func total() -> int:
	return get_child_count()
