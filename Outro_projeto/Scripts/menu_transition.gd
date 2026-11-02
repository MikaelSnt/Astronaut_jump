extends Control
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var menu: Control = $menu


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Global.intro == false:
		animation_player.play("fade_in")
	if Global.intro == true:
		menu.visible = true
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "fade_in":
		animation_player.play("fade_out")
		Global.intro = true
