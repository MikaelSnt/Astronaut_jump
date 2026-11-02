extends inimigo
var lado : int
@onready var texture: AnimatedSprite2D = $texture
func _ready() -> void:
	lado = randi_range(1,2)
	if lado == 2:
		direction.x = 1
		self.z_index = -1
	elif lado == 1:
		direction.x = -1
		self.z_index = 1
func _process(delta: float) -> void:
	move(delta)


func _on_hit_box_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.velocity.x = 0
		body.velocity.y = -1
		body.set_collision_mask_value(1, false)
		await get_tree().create_timer(0.5).timeout
		body.set_collision_mask_value(1, true)
		await get_tree().create_timer(0.1).timeout
		queue_free()
	if body.is_in_group("clean"):
		queue_free()
func move(delta):
	velocity = direction * speed 
	position += velocity * delta
	if position.x >= screen_size.x/2.2:
		direction *= -1
		texture.flip_h = true
	elif  position.x <= -82:
		texture.flip_h = false
		direction *= -1
