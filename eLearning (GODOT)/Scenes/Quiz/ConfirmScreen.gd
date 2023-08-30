extends Control

signal accepted

func _on_button_pressed() -> void:
	accepted.emit()
