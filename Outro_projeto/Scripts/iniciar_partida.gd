extends CanvasLayer
@onready var audio : AudioStreamPlayer = $AudioStreamPlayer
func _ready() -> void:
	if Global.Global_audio == false:
		audio.stop()
