extends Button

@export_multiline
var help_message: String = ""


func display_help() -> void:
	var dialog = AcceptDialog.new()
	dialog.dialog_text = help_message
	dialog.title = "Προσοχή!"
	add_child(dialog)
	dialog.popup_centered()
