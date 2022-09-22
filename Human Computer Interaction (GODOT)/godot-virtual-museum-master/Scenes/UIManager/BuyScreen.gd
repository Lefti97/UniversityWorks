extends AcceptDialog
class_name BuyScreen

const ENTRY_PREFAB = preload("res://Scenes/UIManager/ItemEntry.tscn")
onready var entry_container = get_node("VB/SC/VB")
onready var card_info_popup = get_node("CardInfoPopup")

var total_cost := 0

func _ready() -> void:
	connect("about_to_show", self, "_on_about_to_show")
	connect("confirmed", self, "_on_confirmation")
	card_info_popup.connect("successful_confirm", self, "_on_card_info_successful_confirm")

func _on_about_to_show() -> void:
	total_cost = 0
	print("total items: " + str(len(CART.items)))
	for child in entry_container.get_children():
		entry_container.remove_child(child)
	for item in CART.items:
		var entry = ENTRY_PREFAB.instance()
		entry_container.add_child(entry)
		entry.setup(item)
		total_cost += item.cost
	$VB/TotalCost.text = "Total cost: %d" % total_cost

func _on_confirmation() -> void:
	if len(CART.items) == 0:
		var info_dialog = AcceptDialog.new()
		add_child(info_dialog)
		info_dialog.dialog_text = "Cart is empty! Add a few items to your cart to purchase them."
		info_dialog.popup_exclusive = true
		info_dialog.popup_centered()
		return
	
	card_info_popup.popup_centered()

func _on_card_info_successful_confirm() -> void:
	CART.items.clear()
	var info_dialog = AcceptDialog.new()
	add_child(info_dialog)
	info_dialog.dialog_text = "Purchase complete!"
	info_dialog.popup_exclusive = true
	info_dialog.popup_centered()
	info_dialog.connect("confirmed", self, "_on_confirm_accept_dialog_confirmed") # fuck you gdscript 3 :^)

func _on_confirm_accept_dialog_confirmed() -> void:
	hide()
