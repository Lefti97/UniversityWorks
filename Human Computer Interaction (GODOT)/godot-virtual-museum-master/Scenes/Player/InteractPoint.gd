extends Spatial
class_name InteractPoint

export var interact_name: String = "Interact Point"
export var method: String = "method name"
export var speed: float = 2.0
export var hop_speed: float = 1.0
export var y_offset: float = 1.0

var time: float = 0.0

func _process(delta: float) -> void:
    time += delta
    $Sprite3D.rotate_y(delta * speed)
    $Sprite3D.translation.y = sin(time * hop_speed) * 0.25 + y_offset