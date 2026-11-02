extends Node2D
@onready var audio: AudioStreamPlayer = $audio



func _on_menu_icon_pressed() -> void:
	if Global.Global_audio:
		audio.play()
	if get_tree().change_scene_to_file("res://Outro_projeto/Prefebs/menu.tscn") != OK:
		OS.alert("deu errado")
