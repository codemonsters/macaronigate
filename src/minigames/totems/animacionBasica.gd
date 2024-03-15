extends AnimatedSprite2D

func _ready():
	play("default")

func _on_block_spawner_stun_start():
	
	speed_scale = 0.5

func _on_block_spawner_stun_end():
	
	speed_scale = 1
