extends Node3D



func _ready():
	visible = true

func _on_game_win():
	var tween = get_tree().create_tween().set_trans(Tween.TRANS_EXPO)
	
	tween.tween_property(self, "position", Vector3(0.208, 20, 0.201), 1.3)
