extends PanelContainer


var statistics: Statistics

@export
var final_evaluation_button: Button

@export
var study_container: Control

@export
var quiz_manager: Control

@export
var previous_button: Button

@export
var next_button: Button

@export
var tab_container: TabContainer

@onready
var welcome_panel: Control = get_node("%WelcomePanel")

@onready
var quiz_complete_panel: Control = get_node("%QuizCompletePanel")

var active_chapter: Chapter

var completed_chapters: Dictionary = {
	1: false,
	2: false,
	3: false,
}

var completed_evaluations: Dictionary = {
	1: false,
	2: false,
	3: false,
}

const QUIZ_COMPLETION_MESSAGE = """
[center][wave amp=50 freq=2]Ολοκλήρωσες την αξιολόγηση! Συγχαρητήρια![/wave][/center]

[center]Ολοκλήρωσες [b]{score}[/b] από τα [b]{total}[/b] quiz.
Ο τελικός σου βαθμός είναι [b]{grade}[/b][/center]
"""


func _ready() -> void:
	statistics = get_node("../Στατιστικά")
	welcome_panel.visible = true
	previous_button.pressed.connect(func():
		next_button.disabled = false
		if active_chapter != null:
			active_chapter.previous()
	)

	next_button.pressed.connect(func():
		if active_chapter != null:
			active_chapter.next()
	)

	quiz_manager.all_quizes_completed.connect(func(score, total):
		unlock_all_buttons()
		print("Completed %d out of %d questions" % [score, total])
		var grade = calculate_grade(score, total)
		if grade >= 5.0:
			completed_evaluations[active_chapter.number] = true
		if all_chapters_complete():
			final_evaluation_button.disabled = false
	
		quiz_complete_panel.visible = true
		quiz_complete_panel.get_node("MC/Message").bbcode_text = QUIZ_COMPLETION_MESSAGE.format({
			"score": score,
			"total": total,
			"grade": grade
		})
		tab_container.current_tab = 0

		statistics.record_grade(active_chapter.number, grade)
	)

	quiz_manager.accepted.connect(lock_all_buttons)

	quiz_manager.quiz_completed.connect(func():
		statistics.record_quiz_success()
	)

	quiz_manager.quiz_failed.connect(func():
		statistics.record_quiz_fail()
	)

	tab_container.tab_changed.connect(func(index: int):
		if index == 0:
			print("Switched to study tab")
		elif index == 1:
			if active_chapter.number <= 3 and not completed_chapters[active_chapter.number]:
				var dialog = AcceptDialog.new()
				dialog.title = "Προσοχή"
				dialog.dialog_text = "Πρέπει να ολοκληρώσεις το κεφάλαιο %d πριν ξεκινήσεις την αξιολόγηση" % active_chapter.number
				dialog.exclusive = true
				dialog.confirmed.connect(func():
					tab_container.current_tab = 0
				)
				add_child(dialog)
				dialog.popup_centered()
			else:
				quiz_manager.try_show_quiz_for(active_chapter.number)
	)


func _process(_delta: float) -> void:
	pass


func button_pressed(button: ChapterButton) -> void:
	reset()

	active_chapter = button.chapter_data.instantiate()
	study_container.add_child(active_chapter)

	active_chapter.chapter_completed.connect(func():
		next_button.disabled = true
		completed_chapters[active_chapter.number] = true
	)


func reset() -> void:
	welcome_panel.visible = false
	quiz_complete_panel.visible = false
	remove_children(study_container)
	next_button.disabled = false


var final_evaluation_button_was_disabled: bool
func lock_all_buttons() -> void:
	get_node("%Chapter1").disabled = true
	get_node("%Chapter2").disabled = true
	get_node("%Chapter3").disabled = true

	var final_btn = get_node("%FinalChapter")
	final_evaluation_button_was_disabled = final_btn.disabled
	final_btn.disabled = true

	# Don't allow switching to study tab while taking a test
	quiz_manager.get_parent().set_tab_disabled(0, true)


func unlock_all_buttons() -> void:
	get_node("%Chapter1").disabled = false
	get_node("%Chapter2").disabled = false
	get_node("%Chapter3").disabled = false
	get_node("%FinalChapter").disabled = final_evaluation_button_was_disabled
	quiz_manager.get_parent().set_tab_disabled(0, false)


func calculate_grade(score: float, total: float) -> float:
	return snapped((float(score) / float(total)) * 10, 0.5)


func all_chapters_complete() -> bool:
	return completed_evaluations[1] == true and completed_evaluations[2] == true and completed_evaluations[3] == true


func _on_chapter_1_pressed():
	var button = get_node("%Chapter1")
	button_pressed(button)


func _on_chapter_2_pressed():
	var button = get_node("%Chapter2")
	button_pressed(button)


func _on_chapter_3_pressed():
	var button = get_node("%Chapter3")
	button_pressed(button)


func _on_final_pressed():
	var button = get_node("%FinalChapter")
	button_pressed(button)


func remove_children(node: Node) -> void:
	for child in node.get_children():
		node.remove_child(child)
		child.queue_free()


func _on_previous_pressed() -> void:
	if active_chapter != null:
		active_chapter.previous()


func _on_next_pressed() -> void:
	if active_chapter != null:
		active_chapter.next()
