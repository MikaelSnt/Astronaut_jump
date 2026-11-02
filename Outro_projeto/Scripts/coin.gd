extends Area2D
@export var coins = 1
@onready var coletar: AnimationPlayer = $"../AnimationPlayer"


func _ready():
	coletar.play("idle")
	await get_tree().create_timer(120).timeout
	queue_free()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	

func _on_body_entered(body):
	if body.name == "player":
		coletar.play("moedacoletada")
		print("coletou")
		Global.coins += coins
	if body.is_in_group("clean"):
		queue_free()
func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "moedacoletada":
		queue_free()


func _on_visible_on_screen_enabler_2d_screen_exited() -> void:
	queue_free()
