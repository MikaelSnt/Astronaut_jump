extends Label
func _ready() -> void:
	Global.coins = Global.coins
func _process(delta: float) -> void:
	text = str(int(Global.coins))
