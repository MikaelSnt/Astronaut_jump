extends CharacterBody2D
@onready var anim: AnimatedSprite2D = $anim
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var anim_tree: AnimationTree = $AnimationTree
@onready var audio_jetpack: AudioStreamPlayer2D = $audio_jetpack
@onready var collision: CollisionShape2D = $CollisionShape2D
@onready var vida: Node2D = $Vida
@export var  velocidade_do_jogador : int
@onready var player_attack_instance := preload("res://Outro_projeto/Prefebs/player_attack.tscn")
@onready var player_container: Node2D = $"../player_container"
var  Gravity  := 958
var velocidade_giroscopio := 2000
var jump_velocity := 500
var esta_pulando : bool = false
var topou := 1
var jump_force := 24
var jump_roubo := 455 #330  #450 #410  #350  
var estanopulo := false
var estaroubando := false
@export var space_ativo := false
@onready var screen_size = get_viewport_rect().size
func _ready() -> void:
	vida.visible = false
func _physics_process(delta: float) -> void:
	roubar(delta)
	move_giroscopio(delta)
	movimento_do_jogador(delta) 
	position.x = wrapf(position.x, -9, screen_size.x)
	if space_ativo:
		if Input.is_action_just_pressed("Pulo"):
			anim_tree.set("parameters/conditions/po_volta", false)
			anim_tree.set("parameters/conditions/pode_atacar", true)
			anim_tree.set("parameters/conditions/voeindo", false)
			var player_attack =  player_attack_instance.instantiate()
			player_attack.position = $player_attack_position.global_position
			player_container.call_deferred("add_child", player_attack)
func movimento_do_jogador(delta) -> void:
	if Global.modo_buttons:
		if !space_ativo:
			if not is_on_floor():
				velocity.x = 0
				velocity.y += Gravity * delta
		if Input.is_action_just_pressed("Pulo") and is_on_floor():
			if Global.Global_audio:
				audio_jetpack.play()
			anim_tree.set("parameters/conditions/pode_pular", true)
			anim_tree.set("parameters/conditions/corre_e_pula", true)
			anim_tree.set("parameters/conditions/volta_parado", false)
			velocity.y = -jump_velocity
			esta_pulando = true
		elif is_on_floor():
			if Global.Global_audio:
				audio_jetpack.play()
			esta_pulando = false
		if estanopulo:
				velocity.y -= jump_force * jump_velocity * delta 
				await get_tree().create_timer(0.1).timeout
				estanopulo = false
		var direction = Input.get_axis("mv_esquerdo", "mv_direito")
		if direction:
			velocity.x = lerp(velocity.x, direction * velocidade_do_jogador, 1)
			if direction < 1:
				anim_tree.set("parameters/conditions/pode_correr", false)
				anim_tree.set("parameters/conditions/pode_pular", true)
				anim_tree.set("parameters/conditions/volta_parado", false)
				anim_tree.set("parameters/conditions/corre_e_pula", false)
				anim.flip_h = true
			if direction > 0:
				anim_tree.set("parameters/conditions/pode_correr", false)
				anim_tree.set("parameters/conditions/corre_e_pula", false)
				anim_tree.set("parameters/conditions/volta_parado", false)
				anim.flip_h = false
		else:
			velocity.x = move_toward(velocity.x, 0, velocidade_do_jogador)
			if velocity.x == 0 and esta_pulando == false:
				anim_tree.set("parameters/conditions/volta_parado", true)
				anim_tree.set("parameters/conditions/pode_pular", false)
				anim_tree.set("parameters/conditions/pode_correr", false)
				anim_tree.set("parameters/conditions/corre_e_pula", false)
		if Input.is_action_just_pressed("Pulo") or direction > 0:
			anim_tree.set("parameters/conditions/pode_pular", true)
			anim_tree.set("parameters/conditions/corre_e_pula", true)
			anim_tree.set("parameters/conditions/pode_correr", false)
		if anim.flip_h:
					collision.position.x = -13.636
					$check/CollisionShape2D2.position.x = -13.636
		else:
					collision.position.x = 13.636
					$check/CollisionShape2D2.position.x = 13.636
		move_and_slide()
func roubar(delta):
	if Input.is_action_just_pressed("roubando"):
			velocity.y -= jump_roubo * jump_velocity * delta 
			await get_tree().create_timer(0.1).timeout
			Global.life = Global.life_invencivel
func die_void():
	Global.life -= 2
func die():
	vida.visible = true
	Global.life -= 1
	if Global.life == 3:
		self.modulate = Color("Red")
		await get_tree().create_timer(0.3).timeout
		self.modulate = Color("White")
		vida._dano()
		await get_tree().create_timer(4).timeout
		vida.visible = false
	elif Global.life == 2:
		vida.visible = true
		self.modulate = Color("Red")
		await get_tree().create_timer(0.3).timeout
		self.modulate = Color("White")
		vida._dano_two()
		await get_tree().create_timer(4).timeout
		vida.visible = false
	elif Global.life == 1:
		vida.visible = true
		self.modulate = Color("Red")
		await get_tree().create_timer(0.3).timeout
		self.modulate = Color("White")
		vida._dano_tree()
		await get_tree().create_timer(4).timeout
		vida.visible = false
	elif Global.life == 0:
		vida.visible = true
		self.modulate = Color("Red")
		await get_tree().create_timer(0.3).timeout
		self.modulate = Color("White")
		vida._dano_four()
		await get_tree().create_timer(1).timeout
		vida.visible = false
	if Global.life <= 0 or  Global.life == 0:
		velocity.x = 0
		velocity.y -= 1
		set_collision_mask_value(1, false)
		await get_tree().create_timer(0.5).timeout
		emit_signal("Morreu", 1)
	else:
		set_collision_mask_value(1, true)
		set_collision_layer_value(1, true)
func move_giroscopio(delta):
	if Global.modo_giroscopio:
		if not is_on_floor():
			if Global.Global_audio:
				audio_jetpack.play()
			velocity.x = 0
			velocity.y += Gravity * delta
		if is_on_floor():
			anim_tree.set("parameters/conditions/pode_pular", true)
			anim_tree.set("parameters/conditions/corre_e_pula", true)
			anim_tree.set("parameters/conditions/volta_parado", false)
			audio_jetpack.stop()
			velocity.y = -jump_velocity
		if estanopulo:
				if Global.Global_audio:
					audio_jetpack.play()
				velocity.y -= jump_force * jump_velocity * delta 
				await get_tree().create_timer(0.1).timeout
				estanopulo = false
		var accel = Input.get_accelerometer()
		var direction_two = accel.x 
		if abs(direction_two) < 0.4:
			direction_two = 0
		if direction_two > 0:
			anim.flip_h = false 
		if direction_two < 1:
			anim.flip_h = true
		if anim.flip_h:
					collision.position.x = -13.636
		if !anim.flip_h:
					collision.position.x = 13.636
		velocity.x = direction_two * velocidade_giroscopio  * delta
		move_and_slide()


func _on_check_body_entered(body: Node2D) -> void:
	if body.is_in_group("plataforma"):
		Global.checkpoint = body.global_position
	if body.is_in_group("inimigo"):
		velocity.x = 0
		velocity.y -= 1
		set_collision_mask_value(1, false)
		die()
func space_attack():
	Gravity = 0
	velocity.y = 0
	var velocidade_no_espaco = -100
	self.velocity.y += velocidade_no_espaco
	anim_tree.set("parameters/conditions/pode_pular", false)
	anim_tree.set("parameters/conditions/corre_e_pula", false)
	anim_tree.set("parameters/conditions/volta_parado", false)
	anim_tree.set("parameters/conditions/voeindo", true)
