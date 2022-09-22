extends ConfirmationDialog

signal successful_confirm()

var number_valid := false
var date_valid := false
var pin_valid := false

func _ready() -> void:
	connect("confirmed", self, "_on_confirmation")

func is_valid() -> bool:
	return number_valid and date_valid and pin_valid

func is_number(ch: String) -> bool:
	return ch <= '9' and ch >= '0'

# Validates card number input
func _on_CardNumber_text_changed(new_text: String) -> void:
	number_valid = false
	var node = $VB/HB/CardNumber
	var out = ""
	var index = 0
	for ch in new_text:
		# Limit input to the 16 digits plus 3 '-'
		if index >= 18:
			number_valid = true
		# Only allow number inputs
		if is_number(ch):
			out += ch
			# and automatically insert '-' where needed
			if index == 3 or index == 8 or index == 13:
				out += '-'
		index += 1
		if number_valid:
			break
	
	# Automatically delete '-' when the user erases input by using backspace
	var last = len(out)
	if last > 0:
		if out[last - 1] == '-':
			out.erase(last - 1, 1)
	
	node.text = out
	node.caret_position = len(out)


func _on_Date_text_changed(new_text: String) -> void:
	date_valid = false
	var node = $VB/HB2/Date
	var out = ""
	var index = 0
	for ch in new_text:
		# Limit input to the 6 digits plus 2 '-'
		if index >= 7:
			date_valid = true
		# Only allow number inputs
		if is_number(ch):
			out += ch
			# and automatically insert '-' where needed
			if index == 1 or index == 4:
				out += '-'
		index += 1
		if date_valid:
			break
	
	# Automatically delete '-' when the user erases input by using backspace
	var last = len(out)
	if last > 0:
		if out[last - 1] == '-':
			out.erase(last - 1, 1)
	
	node.text = out
	node.caret_position = len(out)

func _on_PIN_text_changed(new_text: String) -> void:
	pin_valid = false
	var node = $VB/HB3/PIN
	var out = ""
	var index = 0
	for ch in new_text:
		# Limit input to the 3 digits
		if index >= 2:
			pin_valid = true
		# Only allow number inputs
		if is_number(ch):
			out += ch
		index += 1
		if pin_valid:
			break
	node.text = out
	node.caret_position = len(out)

func _on_confirmation() -> void:
	if not is_valid():
		var info = AcceptDialog.new()
		info.popup_exclusive = true
		if not number_valid:
			info.dialog_text += "Card number is not valid!\n"
		if not date_valid:
			info.dialog_text += "Date is not valid!\n"
		if not pin_valid:
			info.dialog_text += "PIN is not valid!\n"
		add_child(info)
		info.popup_centered()
		return
	hide()
	emit_signal("successful_confirm")
