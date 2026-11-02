extends StaticBody2D
class_name plataformas

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "player":
		pass
