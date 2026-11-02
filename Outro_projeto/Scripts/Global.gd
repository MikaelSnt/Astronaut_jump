extends Node
var Highscore := 0
var lastscore := 0
var scoreId
var score = 0
var player_name : String
var player_list := []

var speedrun_time = 0
var speedrun_time_end = 0
var display_speedrun_timer = true

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
func leaderboard():
	for score in Global.score:
		Global.player_list.append(Global.player_name)
