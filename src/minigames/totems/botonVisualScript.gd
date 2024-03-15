extends Button

func _ready():
	self_modulate = Color(1, 1, 1, 1)

func _on_stun_start():
	self_modulate = Color(0.2, 0.2, 0.2, 1)

func _on_stun_end():
	self_modulate = Color(1, 1, 1, 1)
