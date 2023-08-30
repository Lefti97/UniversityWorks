extends PanelContainer
class_name QuizManager

signal all_quizes_completed(current_score: int, total: int)
signal quiz_completed
signal quiz_failed
signal accepted

var active_child_index := 0
var total := 0
var current_score := 0

func _ready() -> void:
	pass


func try_show_quiz_for(chapter: int) -> void:
	for child in get_children():
		remove_child(child)

	var screen = show_confirmation_screen()
	screen.accepted.connect(func():
		show_quiz_for(chapter)
		accepted.emit()
		screen.queue_free()
	)


func show_quiz_for(chapter: int) -> void:
	active_child_index = 0
	current_score = 0
	var quizes = QuizData.QUIZES[chapter]
	total = len(quizes)

	for quiz in quizes:
		match quiz["type"]:
			"m":
				var quiz_scene = preload("res://Scenes/Quiz/multiple_choice.tscn").instantiate()
				add_child(quiz_scene)
				
				quiz_scene.visible = false
				quiz_scene.initialize(quiz)
				quiz_scene.next_button.pressed.connect(next)

				quiz_scene.quiz_completed.connect(func():
					print("SUCCESS")
					current_score += 1
					Notify.successful_endorsment()
					self.quiz_completed.emit()
				)

				quiz_scene.quiz_failed.connect(func():
					print("FAILED")
					Notify.failed_endorsment()
					self.quiz_failed.emit()
				)
			"c":
				var match_scene = preload("res://Scenes/Quiz/MatchQuiz/match.tscn").instantiate()
				add_child(match_scene)
				
				match_scene.visible = false
				match_scene.initialize(quiz)

				match_scene.quiz_completed.connect(func():
					print("SUCCESS")
					current_score += 1
					Notify.successful_endorsment()
					self.quiz_completed.emit()
					next()
				)

				match_scene.quiz_failed.connect(func():
					print("FAILED")
					Notify.failed_endorsment()
					self.quiz_failed.emit()
					next()
				)

	if get_child_count() > 0:
		get_child(active_child_index + 1).visible = true


func next() -> void:
	get_active_quiz().visible = false
	active_child_index += 1
	if active_child_index < get_child_count():
		get_active_quiz().visible = true
	else:
		all_quizes_completed.emit(current_score, total)

func get_active_quiz() -> Control:
	return get_child(active_child_index)


func show_confirmation_screen() -> Control:
	var screen = preload("res://Scenes/Quiz/ConfirmScreen.tscn").instantiate()
	add_child(screen)
	return screen
