extends inimigo
var lado : int
func _ready() -> void:
	lado = randi_range(1,2)
	if lado == 2:
		direction.x = 1
	elif lado == 1:
		direction.x = -1
func _process(delta: float) -> void:
	move(delta)

func move(delta):
	velocity = direction * speed 
	position += velocity * delta
	if position.x >= screen_size.x/2.2:
		anim.play("idle")
		direction *= -1
	elif  position.x <= -82:
		anim.play("voando")
		direction *= -1


func _on_hurt_box_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		direction = Vector2.ZERO
		await get_tree().create_timer(0.5).timeout
		queue_free()


func _on_hit_box_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.die()
