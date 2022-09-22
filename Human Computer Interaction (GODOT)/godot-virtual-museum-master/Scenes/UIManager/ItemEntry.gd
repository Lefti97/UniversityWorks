extends PanelContainer

onready var name_label := get_node("HB/HB/Name")
onready var cost_label := get_node("HB/HB2/Cost")

func setup(data: ExhibitData) -> void:
	name_label.text = data.name
	cost_label.text = str(data.cost)
	
