extends Node

@export
var msg: Label

@export
var player: AnimationPlayer

# //NOTE(minebill): Figure out how to use emojis
const SUCCESSFUL_ENDORSMENTS: Array[String] = [
	"Καλή δουλειά!",
	"Μπράβο!",
]

const FAILED_ENDORSMENTS: Array[String] = [
	"Καλή προσπάθεια!"
]

func _ready() -> void:
	get_tree().root.call_deferred("move_child", self, -1)

func successful_endorsment() -> void:
	if player.is_playing():
		return
	msg.text = SUCCESSFUL_ENDORSMENTS[randi_range(0, len(SUCCESSFUL_ENDORSMENTS) - 1)]
	player.play("Show")

func failed_endorsment() -> void:
	if player.is_playing():
		return
	msg.text = FAILED_ENDORSMENTS[randi_range(0, len(FAILED_ENDORSMENTS) - 1)]
	player.play("Show")
