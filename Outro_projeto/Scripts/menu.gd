extends Control
@onready var audio: AudioStreamPlayer = $audio
@onready var recorde_score: Label = $recorde_score



@onready var aperte_aqui: Label = $aperte_aqui
func _ready() -> void:
	#SilentWolf.Scores.wipe_leaderboard()  Limpar Tabela
	SaveAndload.load_game()
	Global.Global_audio = SaveAndload.save_data.options.sound
	Global.Global_sound_ambient = SaveAndload.save_data.options.music
	recorde_score.text = str(SaveAndload.save_data.life)
func _on_start_btn_pressed() -> void:
	if Global.Global_audio:
		audio.play()
	if !Global.Escolheu_um_modo:
		if get_tree().change_scene_to_file("res://Outro_projeto/Prefebs/control_modos.tscn") != OK:
			OS.alert("deu errado")
	if Global.Escolheu_um_modo:
		if get_tree().change_scene_to_file("res://Outro_projeto/levels/level_1.tscn") != OK:
			OS.alert("deu errado")
func _on_quit_btn_pressed() -> void:
	if Global.Global_audio:
		audio.play()
	get_tree().quit()


func _on_leaderboard_pressed() -> void:
	if Global.Global_audio:
		audio.play()
	if get_tree().change_scene_to_file("res://Outro_projeto/Prefebs/leaderboard.tscn") != OK:
		OS.alert("deu errado")


func _on_loja_pressed() -> void:
	if Global.Global_audio:
		audio.play()
	if get_tree().change_scene_to_file("res://Outro_projeto/Prefebs/loja.tscn") != OK:
		OS.alert("deu errado")


func _on_menu_icon_pressed() -> void:
	if Global.Global_audio:
		audio.play()
	if get_tree().change_scene_to_file("res://Outro_projeto/Prefebs/options.tscn") != OK:
		OS.alert("deu errado")
