extends Node
class_name Cart

var items: Array = [];

func add_to_cart(item: ExhibitData) -> void:
	items.append(item);
