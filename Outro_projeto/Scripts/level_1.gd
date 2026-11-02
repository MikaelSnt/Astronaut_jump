extends Node2D
@onready var boss_positon: Marker2D = $Camera2D/boss_positon
@onready var audio_ambient: AudioStreamPlayer2D = $audio_ambient
@onready var audio_atmosfera: AudioStreamPlayer = $audio_atmosfera
@onready var estratosfera: Sprite2D = $BG/estratosfera
@onready var termosfera: Sprite2D = $BG/termosfera
@onready var exosfera: Sprite2D = $BG/Exosfera
@onready var atmosfera: Label = $Hud/Atmosfera
@onready var nuvens_1: ParallaxLayer = $BG/nuvens1
@onready var nuvens_2: ParallaxLayer = $BG/nuvens2
@onready var nuvens_3: ParallaxLayer = $BG/nuvens3
@onready var nuvens_4: Node2D = $Nuvens4
@onready var stars_small_1: Sprite2D = $"BG/05/StarsSmall1"
@onready var sky: Sprite2D = $"BG/05/Sky"
@onready var plataform_container: Node2D = $plataform_container
@onready var plataform_normal_inicial_position = $plataform_container/plataform.position.y
@onready var player: CharacterBody2D = $player
@onready var camera_2d: Camera2D = $Camera2D
@onready var score_label: Label = $Camera2D/score_label
@export_group("PackedScenes")
@export var iniciar_partida : PackedScene
@onready var aviao_caindo = preload("res://Outro_projeto/Prefebs/aviones.tscn")
@export var plataform_scene : PackedScene 
@export var plataform_scene_two : PackedScene 
@export var plataform_scene_tree : PackedScene 
@export var plataform_scene_inimigo_fly : PackedScene 
@export var plataform_scene_inimigo_satelite_one : PackedScene
@export var plataform_meteoro : PackedScene
@export var plataform_heli : PackedScene
@export var plataform_coin : PackedScene
@export var boss_scene : PackedScene
@onready var plataform_clear: Area2D = $Camera2D/plataform_clear
@onready var player_attack_instance := preload("res://Outro_projeto/Prefebs/player_attack.tscn")
var pode_comeca = false
var camera_start_position = 159.0
var contador = 0
var contadorq = 0
var contadorini = 0
var score : int
var plats : int
var platq : int 
var inifly : int
var satelite : int
var contcoin : int
var contheli : int
var instancia = null
var emissor
func _physics_process(delta: float) -> void:
	if atmosfera.text != "Exosfera":
		if player == null:
				camera_2d.position.y = camera_2d.position.y 
		elif player.position.y < camera_2d.position.y:
				camera_2d.position.y = player.position.y
	score_update()
	atmosfera_update()
	new_boss()
func score_update():
	score = camera_start_position - camera_2d.position.y
	score_label.text = str(int(score))
func level_generator(plataforma_normal):
	var new_plataform = plataform_scene.instantiate() 
	var new_satelite = plataform_scene_inimigo_satelite_one.instantiate() 
	var new_meteoro = plataform_meteoro.instantiate()
	var new_coin = plataform_coin.instantiate()
	for plataforma1 in plataforma_normal:
		if atmosfera.text == "Troposfera" or  atmosfera.text == "Estratosfera":
			plataform_normal_inicial_position -= randi_range(80, 80 * 0.8)
		if atmosfera.text == "Mesosfera":
			plataform_normal_inicial_position -= randi_range(80, 80 * 1.5) 
			new_meteoro.position = Vector2(randi_range(6, 176), plataform_normal_inicial_position * 1.1)
			if satelite > 3:
					plataform_container.call_deferred("add_child", new_meteoro)
					satelite = 0 
		if atmosfera.text == "Termosfera":
				plataform_normal_inicial_position -= randi_range(80, 80 * 2) 
				new_satelite.position = Vector2(randi_range(-5, 190), plataform_normal_inicial_position * 1.1)
				if satelite > 10:
					plataform_container.call_deferred("add_child", new_satelite)
					satelite = 0 
		if atmosfera.text == "Estratosfera":
			new_plataform = plataform_scene_tree.instantiate()
			new_plataform.position = Vector2(randi_range(8, 157), plataform_normal_inicial_position )
			plataform_container.call_deferred("add_child", new_plataform)
			if contheli > 3 and atmosfera.text == "Estratosfera" and score > 2900 and score < 4000: 
					var mew_heli = plataform_heli.instantiate()
					mew_heli.position = Vector2(randi_range(4,167), plataform_normal_inicial_position * 1.5)
					plataform_container.call_deferred("add_child", mew_heli)
					contheli = 0 
		if atmosfera.text == "Exosfera":
			player.space_attack()
			player.space_ativo = true
		if atmosfera.text != "Estratosfera" and atmosfera.text != "Exosfera":
			new_plataform = plataform_scene.instantiate() 
			new_coin.position = Vector2(randi_range(10, 150), plataform_normal_inicial_position * 1.5 )
			new_plataform.position = Vector2(randi_range(8, 157), plataform_normal_inicial_position )
			plataform_container.call_deferred("add_child", new_plataform)
			if contcoin == 5:
				plataform_container.call_deferred("add_child", new_coin)
				contcoin = 0
		plats += 2
		platq += randf_range(1, 25) 
		inifly += 1
		satelite += 1
		contcoin += 1
		contheli += 1
		if plats == 28: 
			contador = 1
			plats = 0
		if platq == 20 or platq  <= 150  or platq == 15 or platq == 10:
			contadorq = 1
			platq = 0
		if inifly == 10:
			contadorini = 1
			inifly = 0
	if score > 1000:
		if score < 2000:
			if contador == 1:
				generator_salto(1)
				contador = 0 
				plats = 0
	if score > 4000:
		if score < 5000:
			if contador == 1:
				generator_salto(1)
				contador = 0 
				plats = 0
	if score >  3000.0:
		if score < 3500:
			if contadorq == 1:
				#generator_nuvem(randf_range(1,1))
				contadorq = 0
				platq = 1
	#if score >  1500.0:
		#if score < 3450:
			#if contadorini == 1:
				#generator_de_inimigo(1)
				#contadorini = 0
				#inifly = 0
	print("plataforma_normal", plataforma_normal)
func generator_salto(plataforma_salto):
		for plataforma2 in plataforma_salto :
			plataform_normal_inicial_position  -= randi_range(80, 80 * 0.8)
			var new_plataform = plataform_scene_two.instantiate()
			new_plataform.position = Vector2(randi_range(8, 157),   plataform_normal_inicial_position )
			plataform_container.call_deferred("add_child", new_plataform)
		print("plataforma_salto", plataforma_salto)
func generator_nuvem(plataforma_queda):
	for plataforma3 in plataforma_queda:
			plataform_normal_inicial_position  -= randi_range(80, 80 * 0.8)
			var new_plataform = plataform_scene_tree.instantiate()
			new_plataform.position = Vector2(randi_range(8, 157),   plataform_normal_inicial_position )	
			plataform_container.call_deferred("add_child", new_plataform)
			print("plataforma_nuvem", plataforma_queda)
#func generator_de_inimigo(plataforma_inimigofly):
		#for plataforma4 in plataforma_inimigofly:
			#plataform_normal_inicial_position -= randi_range(80, 80 * 0.8)
			#var new_plataform = plataform_scene_inimigo_fly.instantiate() 
			#new_plataform.position = Vector2(randi_range(93, 93), plataform_normal_inicial_position )
			#plataform_container.call_deferred("add_child", new_plataform)
			#print("plataforma_inimigofly", plataforma_inimigofly)
func _ready() -> void:
	Global.life = 2
	Global.Global_coins = 0
	Global.coins = 0
	get_tree().paused = true
	var new_scene = iniciar_partida.instantiate() 
	$".".call_deferred("add_child", new_scene)
	await get_tree().create_timer(3.0).timeout
	pode_comeca = true 
	if pode_comeca:
		get_tree().paused = false
		if Global.Global_sound_ambient:
			audio_ambient.play()
		randomize()
		level_generator(5)
		print(player.position)
		if Global.modo_giroscopio:
			$Hud.hide_buttons()
		new_scene.queue_free()

func atmosfera_update():
	if score > 1000 and score < 1080:
		var nueva_cena = aviao_caindo.instantiate()
		if instancia == null:
				instancia = nueva_cena
				nueva_cena.position = Vector2(0, plataform_normal_inicial_position )
				$".".call_deferred("add_child", nueva_cena)
				await get_tree().create_timer(10).timeout
				nueva_cena.queue_free()
		else:
			pass
	if score <= 3000:
		atmosfera.text = "Troposfera"
	if score <= 7000 and score > 3000:
		if score > 3000 and  score <= 3150:
			if Global.Global_audio:
				audio_atmosfera.play()
			atmosfera.text = "Estratosfera"
			Input.vibrate_handheld(50)
			atmosfera.change_altitude()
		player.Gravity = 800
		sky.modulate = Color(0.346, 0.554, 0.555)
		if score > 5000:
			nuvens_1.visible = false
			nuvens_2.visible = false
			nuvens_3.visible = false
			nuvens_4.visible = false
	if score > 7000 and score <= 10000:
		if score > 7000 and score <= 7150:
			if Global.Global_audio:
				audio_atmosfera.play()
			atmosfera.text = "Mesosfera"
			Input.vibrate_handheld(100)
			atmosfera.change_altitude()
			
		player.Gravity = 600
		estratosfera.visible = true
		$BG/StarsSmall2.visible = true
		sky.visible = false
		nuvens_1.visible = false
		nuvens_2.visible = false
		nuvens_3.visible = false
		nuvens_4.visible = false
	if score > 10500 and score <= 15000:
		if score > 10500 and score <= 10580:
			if Global.Global_audio:
				audio_atmosfera.play()
			atmosfera.text = "Termosfera"
			Input.vibrate_handheld(150)
			atmosfera.change_altitude()
		player.Gravity = 400
		estratosfera.visible = false
		$BG/StarsSmall2.visible = false
		termosfera.visible = true
	if score <= 30000 and score > 20000:
		if score > 20000 and score <= 20080:
			if Global.Global_audio:
				audio_atmosfera.play()
			atmosfera.text = "Exosfera"
			Input.vibrate_handheld(200)
			atmosfera.change_altitude()
		player.Gravity = 200
		termosfera.visible = false
		$BG/StarsSmall2.visible = true
		exosfera.visible = true
	if score >  30000:
		exosfera.visible = false
		sky.visible = true
		if score > 30000 and score <= 30080:
			if Global.Global_audio:
				audio_atmosfera.play()
			atmosfera.text = "Espaço"
			Input.vibrate_handheld(250)
			atmosfera.change_altitude()
		sky.modulate = Color("Black")
		$BG/StarsSmall2.visible = false
		stars_small_1.visible = true 
func salvar_score():
	if Global.life <= 0:
				Global.lastscore = score
				if score > Global.Highscore:
					Global.Highscore = score
				if get_tree().change_scene_to_file("res://Outro_projeto/Prefebs/control_high_score.tscn") != OK:
					OS.alert("deu errado")
func _on_plataform_clear_body_entered(body: Node2D) -> void:
	if body.name == "chao":
		await get_tree().create_timer(10).timeout
		body.queue_free()
	if body.is_in_group("plataforma") or body.is_in_group("inimigo"):
		body.queue_free()
	if  body.name == "coin2":
		body.queue_free()
	if body.is_in_group("player"):
		body.die_void()
		if body.name == "player":
			salvar_score()
		elif Global.life != 0:
				player.global_position = Global.checkpoint + Vector2(0, -100)
		if Global.life > 0  and  atmosfera.text == "Estratosfera" or Global.life > 0  and  atmosfera.text == "Mesosfera":
				var new_plataform = plataform_scene.instantiate() 
				new_plataform.position = Vector2(Global.checkpoint.x, Global.checkpoint.y)
				$plataform_container.call_deferred("add_child", new_plataform)
				player.global_position = new_plataform.position + Vector2(10, -200)
				await get_tree().create_timer(1).timeout
	if atmosfera.text == "Exosfera" and score > 20060:
		level_generator(0)
	else:
		level_generator(1)
func resolvendo_bug():
	if player.position.y > plataform_clear.position.y - 1950:
		var new_plataform = plataform_scene.instantiate() 
		new_plataform.position = Vector2(Global.checkpoint.x, Global.checkpoint.y)
		$plataform_container.call_deferred("add_child", new_plataform)
		player.global_position = new_plataform.position + Vector2(10, -200)
		await get_tree().create_timer(1).timeout
func new_boss():
	var new_boss = boss_scene.instantiate()
	if atmosfera.text == "Exosfera" and score > 20000:
		camera_2d.position.y = player.position.y * 1.004
		$Hud.space_hud()
		score_label.modulate = Color("White")
		if instancia == null:
			instancia = new_boss
			level_generator(0)
			$plataform_container.queue_free()
			player.space_attack()
			player.space_ativo = true
			new_boss.global_position = boss_positon.global_position
			$Boss_container.call_deferred("add_child", new_boss) 
