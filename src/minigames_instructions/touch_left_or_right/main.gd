extends Node2D

const wave_delay = 0.2
var scene = preload("res://minigames_instructions/Wave.tscn")
var wave_count = 0


func _ready():
	pass


func _process(delta):
	pass

func touch(pos: int, count: int = 1): # Nombre del marcador y cuántos círculos añadir
	var lista_nodos = get_node("Posiciones puntos")
	for i in range(1, count+1):
		var scene_instance: Sprite2D = scene.instantiate()
		$Waves.add_child(scene_instance)
		var nodo_posicion = lista_nodos.get_node_or_null("WavePos"+ str(pos))
		assert(nodo_posicion != null, "¡Esa posición no existe! Créala :(")
		scene_instance.position = nodo_posicion.position
		
		print(wave_delay * i)
		print("aaa")
		scene_instance.get_node("Timer").wait_time = wave_delay * i
		scene_instance.get_node("Timer").start()
	
