extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	#var tween_title : Tween = get_tree().create_tween()
	
	#tween_title.tween_property($TitleSprite, "position:y", 300, 0.4).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN)
	#tween_title.tween_property($TitleSprite, "position:y", 250, 1).set_trans(Tween.TRANS_SINE)
	$TitleAnimationPlayer.play("In")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_play_button_pressed():
	get_tree().change_scene("res://minigames/happyhippo/main.tscn")
