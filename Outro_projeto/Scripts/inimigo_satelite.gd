extends inimigo
var lado : int
func _ready() -> void:
	lado = randi_range(1,2)
	if lado == 2:
		direction.x = 1
	elif lado == 1:
		direction.x = -1
	await get_tree().create_timer(320).timeout
	queue_free()
func _process(delta: float) -> void:
	move(delta)


func _on_hit_box_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.die()
