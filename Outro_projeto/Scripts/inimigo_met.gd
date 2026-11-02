extends inimigo
@onready var texture: Sprite2D = $texture
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var collision_shape_2d: CollisionShape2D = $hit_box/CollisionShape2D
var lado : int
func _ready() -> void:
	lado = randf_range(1,2)
	if lado == 2:
		texture.flip_h = true
		collision_shape_2d.rotate(-48.9)
		collision_shape_2d.position.x = -0.873
	elif lado == 1:
		texture.flip_h = false
	await get_tree().create_timer(60).timeout
	queue_free()
func _process(delta: float) -> void:
	move_queda(delta)
func _on_hit_box_body_entered(body: Node2D) -> void:
	if body.name == "player":
		body.die()
func move_queda(delta):
	if texture.flip_h == true:
		animation_player.play("queda_esquerda")
	else:
		animation_player.play("queda_direita")
