extends Node
var Escolheu_um_modo = false
var Highscore : int
var GlobalHighscore := 0
var lastscore := 0
var intro := false
var Global_coins := 0
var coins := 0
var scoreId
var sensibilidade : int
var Global_audio := true
var Global_sound_ambient := true
var score = 0
var life := 0
var life_invencivel = 1000
var tentaversevai = false
var player_name : String
var player_list := []
var modo_giroscopio:= false
var modo_buttons:= false
var checkpoint = Vector2.ZERO
func _ready() -> void:
	SilentWolf.configure({
		"api_key": "jIVr0yg9RXTmrgU2Lvnv31HC8xdvjQf8ACC1ZHZc",
		"game_id": "alphafinhaastronauta",
		"log_level": 1
	})
	
	SilentWolf.configure_scores({
		"open_scene_on_close": "res://scenes/MainPage.tscn"
	})
func _physics_process(delta: float) -> void:
	leaderboard()
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		get_tree().change_scene_to_file("res://Outro_projeto/Prefebs/pause_menu.tscn")
func leaderboard():
	for score in Global.score:
		Global.player_list.append(Global.player_name)
