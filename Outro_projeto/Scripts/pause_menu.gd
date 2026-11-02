extends CanvasLayer
@onready var pause_btn: Button = $menu/pause_btn




func _ready():
	visible = true
	get_tree().paused = true
func _unhandled_key_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		visible = true
		get_tree().paused = true
		pause_btn.grab_focus()
func _on_pause_btn_pressed() -> void:
		get_tree().paused = false
		visible = false


func _on_quit_btn_pressed() -> void:
	get_tree().paused = false
	visible = false
	get_tree().change_scene_to_file("res://Outro_projeto/Prefebs/menu.tscn")


func _on_reset_pressed() -> void:
	get_tree().paused = false
	visible = false
	get_tree().change_scene_to_file("res://Outro_projeto/levels/level_1.tscn")


func _on_pause_btna_pressed() -> void:
	$"..".hide()
	$".".visible = true
	get_tree().paused = true


func _on_options_pressed() -> void:
	get_tree().paused = false
	visible = false
	get_tree().change_scene_to_file("res://Outro_projeto/Prefebs/options.tscn")


func _on_escolher_modo_pressed() -> void:
	get_tree().paused = false
	visible = false
	get_tree().change_scene_to_file("res://Outro_projeto/Prefebs/control_modos.tscn")
