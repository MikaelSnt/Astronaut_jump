extends Node2D
@onready var anim: AnimationPlayer = $AnimationPlayer
func _physics_process(delta: float) -> void:
	pass
func _dano():
	anim.play("dano")
func _dano_two():
	anim.play("dano_2")
func _dano_tree():
	anim.play("dano_3")
func _dano_four():
	anim.play("dano_4")
