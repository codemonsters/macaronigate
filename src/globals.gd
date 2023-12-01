extends Node

# Poner aquí todo el código y las variables generales del juego
# (todo lo que es independiente de los minijuegos, del menú, etc)
#
# Este script es cargado automáticamente desde los settings del proyecto
#var minigames = ["frutas", "happyhippo"] #, "esquivar.coches", "ladronesDeDiamantes", "space", "totem.break", "ñarkanoid"]

#func _ready():
#	for minigame in minigames:
#		pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func comenzar_partida():
	print("Comienza la partida (TODO: inicializar variables y cargar el primer minijuego)")
	get_tree().change_scene_to_file("res://minigames/game.tscn")
