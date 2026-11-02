extends CanvasLayer
var load_pause = preload("res://Outro_projeto/Prefebs/pause_menu.tscn")
@onready var margin_container: MarginContainer = $MarginContainer
@onready var attack_button: TouchScreenButton = $MarginContainer/attack_button
@onready var touch_screen_button_3: TouchScreenButton = $MarginContainer/TouchScreenButton3
@onready var altura_2: Label = $Altura/Altura2
@onready var altura: Label = $Altura
@onready var atmosfera: Label = $Atmosfera
func _on_pause_btna_pressed() -> void:
	$AudioStreamPlayer.play()
	var  pause = load_pause.instantiate()
	$"..".call_deferred("add_child", pause)
	get_tree().paused = false
func _process(delta: float) -> void:
	#score_coins.text = str(Global.coins)
	pass
func _ready() -> void:
	attack_button.visible = false 
func hide_buttons():
	margin_container.hide()
func space_hud():
	altura.modulate = Color("White")
	altura_2.self_modulate = Color("White")
	touch_screen_button_3.hide()
	attack_button.visible = true 
	attack_button.PROCESS_MODE_INHERIT  
