extends inimigo
class_name boss
@onready var check_player: CollisionShape2D = $check_player_area/check_player
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var animation_tree: AnimationTree = $AnimationTree
@onready var attack_one = preload("res://Outro_projeto/Prefebs/ovni_attack.tscn")
@onready var attack_one_2 = preload("res://Outro_projeto/Prefebs/ovni_attack.tscn")
@onready var attack_one_3 = preload("res://Outro_projeto/Prefebs/ovni_attack.tscn")
@onready var barra_de_vida: TextureProgressBar = $TextureProgressBar/Barra_de_vida

var lado : int
var attack_contagem := 0
var mudar_de_modo = false
var modo_attack2 = false
@export var  maxhp := 50
var dano_tomado := 1.0
func _ready() -> void: 
	barra_de_vida.max_value = maxhp
	lado = 1
	if lado == 2:
		direction.x = 1
	elif lado == 1:
		direction.x = -1
func _process(delta: float) -> void:
	move(delta)
func move(delta):
	velocity.x = direction.x * speed 
	position += velocity * delta
	if position.x >= screen_size.x/2.2:
		direction *= -1
	elif  position.x <= -82:
		direction *= -1
	velocity.y = -100
func attack():
	if !mudar_de_modo:
		attack_contagem = 0
	if attack_contagem == 0:
			$Marker2D.position = self.position
			var attack2 = attack_one.instantiate()
			animation_tree.set("parameters/conditions/attack_player", true)
			attack2.position = $Marker2D.position
			$"../attack_positions".call_deferred("add_child", attack2)
			if !mudar_de_modo:
				attack_contagem = 1
				await get_tree().create_timer(5).timeout
				attack_contagem = 0
			if mudar_de_modo:
				pass
	if mudar_de_modo:
			attack_contagem = 3
			if attack_contagem == 3:
				$Marker2D.position = self.position
				var attack1 = attack_one_2.instantiate()
				var attack2 = attack_one.instantiate()
				var attack3 = attack_one_3.instantiate()
				animation_tree.set("parameters/conditions/attack_player", true)
				attack2.position = Vector2($Marker2D.position.x * 1, $Marker2D.position.y)
				$"../attack_positions".call_deferred("add_child", attack2)
				attack1.position = Vector2($Marker2D.position.x * 2, $Marker2D.position.y)
				$"../attack_positions".call_deferred("add_child", attack1)
	if modo_attack2 == true:
			attack_contagem = 4
			if attack_contagem == 4:
				$Marker2D.position = self.position
				var attack1 = attack_one_2.instantiate()
				var attack2 = attack_one.instantiate()
				var attack3 = attack_one_3.instantiate()
				animation_tree.set("parameters/conditions/attack_player", true)
				attack2.position = Vector2($Marker2D.position.x * 1, $Marker2D.position.y)
				$"../attack_positions".call_deferred("add_child", attack2)
				attack1.position = Vector2($Marker2D.position.x * 2, $Marker2D.position.y)
				$"../attack_positions".call_deferred("add_child", attack1)
				attack3.position = Vector2($Marker2D.position.x * -1, $Marker2D.position.y)
				$"../attack_positions".call_deferred("add_child", attack3)
func _on_check_player_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		attack()
func boss_dano():
	barra_de_vida.value += dano_tomado
	if barra_de_vida.value == maxhp/2:
		mudar_de_modo = true
		modo_attack2 = false
		self.speed = 200
	if barra_de_vida.value == maxhp/1.4:
		mudar_de_modo = false
		modo_attack2 = true
		self.speed = 100
	if barra_de_vida.value == maxhp:
		animation_tree.set("parameters/conditions/attack_player", false)
		animation_tree.set("parameters/conditions/explodir", true)
		await animation_tree.animation_finished == "explodir"
		queue_free()
