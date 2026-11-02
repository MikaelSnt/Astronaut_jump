extends MarginContainer

@onready var loading_screen = preload("res://Outro_projeto/Prefebs/loading.tscn")
@onready var alert: Label = $"../enviar"
@onready var submit: Button = $"../Submit"
@onready var audio: AudioStreamPlayer = $"../audio"
@onready var name_input: LineEdit = $"../name_input"

var temnome := {"tem": false}
var leader_scene = preload("res://Outro_projeto/Prefebs/leaderboard.tscn")

# Impede que o jogador envie o score várias vezes ao clicar rapidamente
var enviando_score := false

func salvar_ou_atualizar_score(nome: String, novo_score: int) -> Dictionary:

	# Procura todos os scores desse jogador
	var resultado = await SilentWolf.Scores.get_scores_by_player(
		nome,
		100
	).sw_get_player_scores_complete


	var scores_existentes: Array = resultado.get("scores", [])

	if scores_existentes.is_empty():



		var novo_resultado = await SilentWolf.Scores.save_score(
			nome,
			novo_score
		).sw_save_score_complete



		return novo_resultado

	var melhor_score = scores_existentes[0]

	for score_data in scores_existentes:

		if int(score_data["score"]) > int(melhor_score["score"]):
			melhor_score = score_data


	var melhor_valor := int(melhor_score["score"])
	var melhor_id := str(melhor_score["score_id"])



	if novo_score <= melhor_valor:


		for score_data in scores_existentes:

			var id := str(score_data["score_id"])

			if id != melhor_id:



				var delete_result = await SilentWolf.Scores.delete_score(
					id
				).sw_delete_score_complete



		return melhor_score




	for score_data in scores_existentes:

		var id := str(score_data["score_id"])


		var delete_result = await SilentWolf.Scores.delete_score(
			id
		).sw_delete_score_complete



	var save_result = await SilentWolf.Scores.save_score(
		nome,
		novo_score
	).sw_save_score_complete

	if save_result.is_empty():

		return {}





	return save_result


func _on_submit_pressed() -> void:

	if enviando_score:

		return

	var nome := name_input.text.strip_edges()

	if nome == "":
		alert.visible = true
		return

	enviando_score = true
	submit.disabled = true


	if Global.Global_audio:
		audio.play()

	Global.player_name = nome

	SaveAndload.save_data.name = nome

	temnome.tem = true





	var sw_result = await salvar_ou_atualizar_score(
		Global.player_name,
		Global.lastscore
	)

	if sw_result.is_empty():

		print("ERRO: Não foi possível salvar o score.")

		alert.text = "Erro ao salvar o score."
		alert.visible = true

		enviando_score = false
		submit.disabled = false

		return


	Global.scoreId = str(sw_result["score_id"])



	SaveAndload.save_data.temnome.tem = temnome

	SaveAndload.save_game()


	alert.hide()
	submit.hide()



	get_tree().change_scene_to_file(
		"res://Outro_projeto/Prefebs/leaderboard.tscn"
	)

func _ready() -> void:

	temnome.tem = SaveAndload.save_data.temnome.tem


	if temnome.tem:

		name_input.editable = false
		name_input.text = str(SaveAndload.save_data.name)

	else:

		name_input.editable = true


	Global.Global_coins += Global.coins

	SaveAndload.save_data.coin += Global.Global_coins



	Global.Highscore = SaveAndload.save_data.life

	if Global.Highscore < Global.lastscore:

		SaveAndload.save_data.life = Global.lastscore



func _process(delta: float) -> void:
	pass


func _on_name_input_focus_entered() -> void:

	if Global.Global_audio:
		audio.play()

	alert.visible = false



func _on_retry_btn_pressed() -> void:

	if Global.Global_audio:
		audio.play()

	get_tree().change_scene_to_file(
		"res://Outro_projeto/Prefebs/menu.tscn"
	)



func _on_leaderboard_pressed() -> void:

	if Global.Global_audio:
		audio.play()

	if get_tree().change_scene_to_file(
		"res://Outro_projeto/Prefebs/leaderboard.tscn"
	) != OK:

		OS.alert("deu errado")



func _on_loja_pressed() -> void:

	if Global.Global_audio:
		audio.play()

	if get_tree().change_scene_to_file(
		"res://Outro_projeto/Prefebs/loja.tscn"
	) != OK:

		OS.alert("deu errado")

func _on_menu_icon_pressed() -> void:

	if Global.Global_audio:
		audio.play()

	if get_tree().change_scene_to_file(
		"res://Outro_projeto/Prefebs/options.tscn"
	) != OK:

		OS.alert("deu errado")
