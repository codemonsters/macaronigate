extends Sprite3D


func _on_game_win():
	var tween = get_tree().create_tween().set_trans(Tween.TRANS_EXPO)
	
	tween.set_parallel(true)
	
	tween.tween_property(self, "modulate", Color(255, 255, 255, 255), 0.8).set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(self, "position", Vector3(position.x, 13, position.z), 1)
	
