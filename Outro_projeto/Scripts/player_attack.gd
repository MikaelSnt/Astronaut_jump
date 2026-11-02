extends attack_class

func _ready() -> void:
	direction.y -= 1
	await get_tree().create_timer(10).timeout
	queue_free()
func _process(delta: float) -> void:
	velocity = direction * speed 
	position += velocity * delta  


func _on_hit_body_entered(body: Node2D) -> void:
	if body.is_in_group("inimigo_boss"):
		print("pegou_no_boss")
		body.boss_dano()
		queue_free()
