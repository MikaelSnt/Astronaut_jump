extends StaticBody2D
class_name attack_class
var direction := Vector2(0,0)
var velocity := Vector2.ZERO
@export var speed := 100


func _ready() -> void:
	direction.y += 1
	await get_tree().create_timer(5).timeout
	queue_free()
func _process(delta: float) -> void:
	velocity = direction * speed 
	position += velocity * delta
func _on_hit_box_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		print("pegou_player")
		body.die()
		queue_free() 
