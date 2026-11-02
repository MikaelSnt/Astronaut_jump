extends StaticBody2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "player":
		Global.checkpoint = self.global_position
		await get_tree().create_timer(1.8).timeout
		animation_player.play("balanco")
		await animation_player.animation_finished == "balanco"
		queue_free()
