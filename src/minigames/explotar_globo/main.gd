extends Node2D

# CREDITS: Imagen de la mano encontrada en https://www.freeimages.com/es/photo/hand-on-flat-surface-1632654

signal game_over
signal game_cleared

@export var clicks_needed = 3 	# número de clicks necesarios para que el globo explote
@export var game_brief = "Blow up!"
@export var needs_timer = true
@export var timer_seconds = 10

# TODO: Corregir esto para que cargue la escena (preferible usando una ruta relativa)
var piece_01_factory = preload("res://piece_01.tscn")

func _ready():
	game_over.connect(Callable(get_parent(), "on_game_over"))
	game_cleared.connect(Callable(get_parent(), "on_game_cleared")) 

func on_game_timeout():
	game_over.emit()

func _process(delta):
	pass


func _on_button_pressed():
	$globo.scale.x += 0.01
	$globo.scale.y += 0.01
	
	clicks_needed -= 1	
	print(clicks_needed)
	if clicks_needed <= 0:
		game_cleared.emit()
		$globo.visible = false
		$WhiteLightTimer.start()


func _on_white_light_timer_timeout():
	# TODO: Revisar esto
	var piece = piece_01_factory.instantiate()
	$PiecesContainer.add_child(piece)

