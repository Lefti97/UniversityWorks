extends Node
class_name UIManager

onready var _PROMPT: Label = get_node("Prompt");
onready var _INFO_POPUP: WindowDialog = get_node("InfoPopUp/WindowDialog");
onready var _CART_ITEMS: Label = get_node("CartPrompt/HBoxContainer/ItemCount");
onready var _BUY_SCREEN: BuyScreen = get_node("BuyScreen")
# What is the current item
var _CURRENT_ITEM: ExhibitData = null;

func _ready() -> void:
	_INFO_POPUP.connect("popup_hide", self, "on_generic_popup_close");
	_BUY_SCREEN.connect("popup_hide", self, "on_generic_popup_close");
	$HelpDialog.connect("popup_hide", self, "on_generic_popup_close")
	_INFO_POPUP.get_node("VBoxContainer/Button").connect("button_up", self, "_on_add_to_cart");

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("test_open_cart"):
		open_cart()
	if event.is_action_pressed("open_help"):
		open_help()

## Show the cart
func open_cart():
	$BuyScreen.popup_centered()
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func open_help():
	$HelpDialog.popup_centered()
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

## A helper method to get if there is any visible popup
func active_popup() -> bool:
	return _INFO_POPUP.visible or _BUY_SCREEN.visible or $HelpDialog.visible;

## Set the text of the prompt to the given text and make it visible
func spawn_prompt(text: String) -> void:
	_PROMPT.text = text
	_PROMPT.show()

## Hide the prompt
func destroy_prompt() -> void:
	_PROMPT.hide()

## Open a window with the given title and info text.
## Note that the text is BBCode enabled
func spawn_info(data: ExhibitData) -> void:
	_CURRENT_ITEM = data;
	var text_lbl = _INFO_POPUP.get_node("VBoxContainer/RichTextLabel");
	_INFO_POPUP.window_title = data.name;
	_INFO_POPUP.popup_centered_ratio(0.6);
	text_lbl.text = data.description;

func on_generic_popup_close() -> void:
	# Capture the mouse!
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _on_add_to_cart() -> void:
	if _CURRENT_ITEM == null:
		# This really shouldn't happen
		return;
	CART.add_to_cart(_CURRENT_ITEM);
	_CART_ITEMS.set_text(String(CART.items.size()));
	_INFO_POPUP.hide()
