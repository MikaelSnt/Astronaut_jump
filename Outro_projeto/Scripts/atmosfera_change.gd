extends Label
@onready var animation_player: AnimationPlayer = $AnimationPlayer
func _ready() -> void:
		animation_player.play("change_atmosfera")
func change_altitude():
	animation_player.play("change_atmostude")
