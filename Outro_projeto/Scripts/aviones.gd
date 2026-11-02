extends Node2D
@onready var anim: AnimationPlayer = $anim

func _ready() -> void:
	anim.play("aviones_passando")
func _on_anim_animation_finished(anim_name: StringName) -> void:
	if anim_name == "aviones_passando":
		queue_free()
