extends Node2D
@onready var name_input: LineEdit = $name_input
@onready var audio: AudioStreamPlayer = $audio
var options := {"sound": true,"music": true,"shield":false}
@onready var check_music: CheckButton = $Icone_music/Check_music
@onready var check_sound: CheckButton = $Icone_sound/Check_sound

func _ready() -> void:
	options = SaveAndload.save_data.options
	update_button()
func _physics_process(delta: float) -> void:
	atualize()
func _on_check_sound_toggled(toggled_on: bool) -> void:
	if toggled_on:
		Global.Global_audio = true
		options.sound = true
	if !toggled_on:
		Global.Global_audio = false
		options.sound = false
func _on_check_music_toggled(toggled_on: bool) -> void:
	if toggled_on:
		Global.Global_sound_ambient = true
		options.music = true
	if !toggled_on:
		Global.Global_sound_ambient = false
		options.music = false
		
func atualize():
	SaveAndload.save_data.options = options
	SaveAndload.save_game()
func update_button():
	if options.sound:
		check_sound.button_pressed = true
		Global.Global_audio = true
	if options.music:
		check_music.button_pressed = true
		Global.Global_sound_ambient = true
	if !options.sound:
		check_sound.button_pressed = false
		Global.Global_audio = false
	if !options.music:
		check_music.button_pressed = false
		Global.Global_sound_ambient = false
func _on_loja_pressed() -> void:
	if Global.Global_audio:
		audio.play()
	if get_tree().change_scene_to_file("res://Outro_projeto/Prefebs/loja.tscn") != OK:
		OS.alert("deu errado")


func _on_icon_astro_pressed() -> void:
	if Global.Global_audio:
		audio.play()
	get_tree().change_scene_to_file("res://Outro_projeto/Prefebs/menu.tscn")


func _on_button_pressed():
	if Global.Global_audio:
		audio.play()
	if name_input.text != "":
		SaveAndload.save_data.name = name_input.text
	SaveAndload.save_game()
