extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	#var tween_title : Tween = get_tree().create_tween()
	
	#tween_title.tween_property($TitleSprite, "position:y", 300, 0.4).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN)
	#tween_title.tween_property($TitleSprite, "position:y", 250, 1).set_trans(Tween.TRANS_SINE)
	$DissolveRect.get_node("AnimationPlayer").play("fade_in")


func _on_play_button_pressed():
	get_tree().change_scene("res://minigames/happyhippo/main.tscn")


func _on_fade_in_animation_finished(anim_name):
	$TitleSprite.get_node("AnimationPlayer").play("in")
