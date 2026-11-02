extends StaticBody2D
class_name inimigo
@onready var anim: AnimatedSprite2D = $anim
var direction := Vector2(0,0)
var velocity := Vector2.ZERO
@export var speed := 100
@onready var screen_size = get_viewport_rect().size
func _ready() -> void:
	pass
func _process(delta: float) -> void:
	move(delta)
func move(delta):
	velocity = direction * speed 
	position += velocity * delta
	if position.x >= screen_size.x/2.2:
		direction *= -1
	elif  position.x <= -82:
		direction *= -1
