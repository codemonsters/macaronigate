extends Node2D
signal play_button_pressed

func _ready():
	play_button_pressed.connect(Callable(get_parent(), "on_play_button_pressed"))

	PhysicsServer2D.area_set_param(get_world_2d().space, PhysicsServer2D.AREA_PARAM_GRAVITY_VECTOR, Vector2(0, 1))	# Establecemos la dirección de la gravedad hacia abajo (lo normal)
	$DissolveRect.get_node("AnimationPlayer").play("fade_in")
	$Title.get_node("AnimatedSprite2D").play("default")
	$PlayButton.get_node("AnimatedSprite2D").play("default")


func _on_play_button_pressed():
	emit_signal("play_button_pressed")
