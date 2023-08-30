extends Node
class_name Statistics

const entry_prefab = preload("res://Scenes/stat_entry.tscn")

@export
var grades_container: Control

@export
var quizes_container: Control


var database := {
	"grades": {
		0: [],
		1: [],
		2: [],
		3: [],
	},
	"failed_quizes": 0,
	"completed_quizes": 0,
}


func _ready() -> void:
	display()


func display() -> void:
	clear_children(grades_container)
	clear_children(quizes_container)

	for key in database["grades"]:
		var stat_entry = entry_prefab.instantiate()
		if key == 3:
			stat_entry.set_data("    Τελική Αξιολόγηση", str(database["grades"][key]))
		else:
			stat_entry.set_data("    Κεφάλαιο %d" % (key + 1), str(database["grades"][key]))
		grades_container.add_child(stat_entry)

	var completed_entry = entry_prefab.instantiate()
	completed_entry.set_data("    Σωστές ερωτήσεις", str(database["completed_quizes"]))
	quizes_container.add_child(completed_entry)

	var failed_entry = entry_prefab.instantiate()
	failed_entry.set_data("    Λανθασμένες ερωτήσεις", str(database["failed_quizes"]))
	quizes_container.add_child(failed_entry)


func record_grade(chapter: int, grade: float) -> void:
	assert(chapter >= 1 and chapter <= 4)
	assert(grade >= 0.0 and grade <= 10.0)
	database["grades"][chapter - 1].append(grade)
	display()


func record_evaluation(chapter: int) -> void:
	pass


func record_quiz_success() -> void:
	database["completed_quizes"] += 1


func record_quiz_fail() -> void:
	database["failed_quizes"] += 1


func clear_children(node: Node) -> void:
	for child in node.get_children():
		node.remove_child(child)
