extends Node3D

func _ready():
	visible = true

func _on_game_win():
	visible = false
