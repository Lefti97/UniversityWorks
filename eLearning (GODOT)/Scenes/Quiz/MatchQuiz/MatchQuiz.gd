extends Control

signal quiz_completed
signal quiz_failed

const left_item_prefab = preload("res://Scenes/Quiz/MatchQuiz/left_item.tscn")
const right_item_prefab = preload("res://Scenes/Quiz/MatchQuiz/right_item.tscn")

@export
var a_column: Container

@export
var b_column: Container

@export
var line: Line2D

@onready
var next_button: Button = get_node("%NextButton")

var active_item: Node
var last_nearest_item: Node

var connections: Dictionary = {}
var correct_connections: Dictionary = {}


func _ready() -> void:
	next_button.pressed.connect(validate_connections)


func _process(_delta: float) -> void:
	if line.points.size() == 2:
		var mouse = get_mouse_position()
		var snap_position := mouse
		last_nearest_item = get_nearest_item(mouse)
		if last_nearest_item != null:
			snap_position = get_control_position(last_nearest_item.anchor)

		line.set_point_position(1, snap_position)


func initialize(data: Dictionary) -> void:
	$VB/Label.text = data["question"]
	correct_connections = data["correct"]
	initialize_items(a_column, left_item_prefab, data["a"])
	initialize_items(b_column, right_item_prefab, data["b"])


func initialize_items(where: Node, item: PackedScene, data: Dictionary) -> void:
	for key in data:
		var node = item.instantiate()
		node.initialize(key, data[key])
		where.add_child(node)

		# Callbacks
		node.button.button_down.connect(func():
			if node.used: return
			start_line_drawing(node)
		)
		node.button.button_up.connect(func():
			if last_nearest_item == null:
				line.clear_points()
				return

			stop_line_drawing()
		)


func validate_connections() -> void:
	print(connections)
	var passed := true
	for key in correct_connections:
		if not connections.has(key):
			passed = false
			break
		if correct_connections[key] != connections[key]:
			passed = false
			break

	if passed:
		quiz_completed.emit()
	else:
		quiz_failed.emit()


func start_line_drawing(item: Node) -> void:
	print("Drawing line!")
	active_item = item
	line.clear_points()
	line.add_point(get_control_position(item.anchor))
	line.add_point(get_mouse_position())


func stop_line_drawing() -> void:
	active_item.used = true
	last_nearest_item.used = true
	var dup = line.duplicate()
	dup.name = "connection_" + ""
	self.add_child(dup)
	line.clear_points()

	# If the key is an int then the connection is from a -> b
	# else it's b -> a
	if active_item.key is int:
		connections[active_item.key] = last_nearest_item.key
	else:
		connections[last_nearest_item.key] = active_item.key


func get_nearest_item(pos: Vector2) -> Node:
	var targets = (b_column if active_item.get_parent() == a_column else a_column).get_children()
	for target in targets:
		if not target.used and get_control_position(target.anchor).distance_to(pos) <= 10:
			return target
	return null


func get_control_position(c: Control) -> Vector2:
	return c.global_position - global_position


func get_mouse_position() -> Vector2:
	return get_viewport().get_mouse_position() - global_position
