extends Node

export(NodePath) onready var screen = get_node(screen) as MeshInstance
export(Array) var lights = []

var tween: Tween
var player: VideoPlayer
var playing: bool = false

func _ready() -> void:
	tween = $Tween
	player = $VideoPlayer
	player.connect("finished", self, "_on_video_player_finished")

func begin_video() -> void:
	if playing:
		stop_video()
		return
	playing = true
	player.stream = preload("res://assets/video.webm")

	var mat: SpatialMaterial = SpatialMaterial.new()
	mat.albedo_texture = player.get_video_texture()
	mat.flags_unshaded = true
	screen.material_override = mat

	player.play()
	dim_lights()


func stop_video() -> void:
	playing = false
	player.stop()
	restore_lights()

func _on_video_player_finished() -> void:
	playing = false
	restore_lights()

func dim_lights() -> void:
	for omni in lights:
		dim_light(get_node(omni) as OmniLight)
	var _a = tween.start()

func restore_lights() -> void:
	for omni in lights:
		restore_light(get_node(omni) as OmniLight)
	var _a = tween.start()

func dim_light(omni: OmniLight) -> void:
	var _ret = tween.interpolate_property(omni, "light_energy", 1, 0.2, 1.5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)

func restore_light(omni: OmniLight) -> void:
	var _ret = tween.interpolate_property(omni, "light_energy", 0.2, 1, 1.5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
