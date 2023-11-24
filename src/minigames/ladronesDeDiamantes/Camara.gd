extends Camera3D


func _ready():
	var tween = get_tree().create_tween().set_trans(Tween.TRANS_EXPO)
	fov = 75;
	
	tween.tween_property(self, "fov", 40, 1.5)


func _on_game_lose():
	var tween = get_tree().create_tween().set_trans(Tween.TRANS_SINE)
	tween.tween_property(self, "fov", 55, 0.5)
