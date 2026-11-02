extends Control
@onready var audio: AudioStreamPlayer = $audio


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_controles_pressed() -> void:
	if Global.Global_audio:
		audio.play()
	Global.modo_buttons = true
	Global.modo_giroscopio = false
	get_tree().change_scene_to_file("res://Outro_projeto/levels/level_1.tscn")
	Global.Escolheu_um_modo = true

func _on_sem_controles_pressed() -> void:
	if Global.Global_audio:
		audio.play()
	Global.modo_giroscopio = true
	Global.modo_buttons = false
	get_tree().change_scene_to_file("res://Outro_projeto/levels/level_1.tscn")
	Global.Escolheu_um_modo = true
func _on_leaderboard_pressed() -> void:
	if Global.Global_audio:
		audio.play()
	if get_tree().change_scene_to_file("res://Outro_projeto/Prefebs/leaderboard.tscn") != OK:
		OS.alert("deu errado")


func _on_icon_astro_pressed() -> void:
	if Global.Global_audio:
		audio.play()
	get_tree().change_scene_to_file("res://Outro_projeto/Prefebs/menu.tscn")


func _on_loja_pressed() -> void:
	if Global.Global_audio:
		audio.play()
	if get_tree().change_scene_to_file("res://Outro_projeto/Prefebs/loja.tscn") != OK:
		OS.alert("deu errado")
