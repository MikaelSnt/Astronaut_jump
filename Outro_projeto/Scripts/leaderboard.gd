extends GridContainer
@onready var audio: AudioStreamPlayer = $"../audio"
@onready var recome: Label = $"../Recome"
@onready var player_position: Label = $"../player_position"
var player_list_with_pos = []
var pos_vbox = VBoxContainer.new()
var name_vbox = VBoxContainer.new()
var score_vbox = VBoxContainer.new()
var loading_scene = preload("res://Outro_projeto/Prefebs/loading.tscn")
func _ready() -> void:
	var load =  loading_scene.instantiate()
	load.scale = $"../Marker2Df".scale
	$"../Marker2Df".call_deferred("add_child", load)
	var sw_result: Dictionary = await SilentWolf.Scores.get_scores(10).sw_get_scores_complete   
	player_list_with_pos = sort_players_and_add_position(SilentWolf.Scores.scores)
	sw_result = await SilentWolf.Scores.get_score_position(Global.scoreId).sw_get_position_complete
	player_position.text = "Você está em: " + str(sw_result.position) + "º"
	load.queue_free()
	add_player_to_grid(player_list_with_pos)
	if Global.Escolheu_um_modo == true:
		recome.modulate = Color("White")
func atualizar_score_por_nome(player_name: String, novo_score : int):
	for player in SilentWolf.Scores.scores:
		if player["player_name"].to_lower() == player.name.to_lower():
			player["score"] = novo_score
			return 
	SilentWolf.Scores.scores.append({
		"player_name": player_name,
		"score": novo_score
	})
func add_player_to_grid(player_list):
	for score_data in player_list:
		var pos_label = Label.new()
		pos_label.text = str(score_data["position"])
		pos_label.show()
		pos_vbox.add_child(pos_label)
	add_child(pos_vbox)
	
	for score_data in player_list:
		var name_label = Label.new()
		name_label.text = str(score_data["player_name"])
		name_label.show()
		name_vbox.add_child(name_label)
	add_child(name_vbox)
	
	for score_data in player_list:
		var score_label = Label.new()
		score_label.text = str(int(score_data["score"]))
		score_label.show()
		score_vbox.add_child(score_label)
	add_child(score_vbox)

func sort_by_score_ascending(a, b):
	return a["score"] > b["score"]

func sort_players_and_add_position(player_list):
	player_list.sort_custom(sort_by_score_ascending)
	
	var position = 1

	for player in player_list:
		player["position"] = position
		position += 1
		
	return player_list


func _on_icon_astro_pressed() -> void:
	if Global.Global_audio:
		audio.play()
	if get_tree().change_scene_to_file("res://Outro_projeto/Prefebs/menu.tscn") != OK:
		OS.alert("deu errado")


func _on_reset_game_pressed() -> void:
	if Global.Global_audio:
		audio.play()
	if Global.Escolheu_um_modo == true:
		recome.modulate = Color(1.0, 1.0, 1.0, 0.22)
		if get_tree().change_scene_to_file("res://Outro_projeto/levels/level_1.tscn") != OK:
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
