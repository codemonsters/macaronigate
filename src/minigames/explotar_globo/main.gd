extends Node2D

# CREDITS: Imagen de la mano encontrada en https://www.freeimages.com/es/photo/hand-on-flat-surface-1632654

signal game_over
signal game_cleared

var clicks_needed = randi_range(15, 25) 	# número de clicks necesarios para que el globo explote
@export var game_brief = "Blow up!"
@export var needs_timer = true
@export var timer_seconds = 6

var balloon_popped = false

var piece_01_factory = preload("res://minigames/explotar_globo/balloon_pieces/piece_01.tscn")
var piece_02_factory = preload("res://minigames/explotar_globo/balloon_pieces/piece_02.tscn")
var piece_03_factory = preload("res://minigames/explotar_globo/balloon_pieces/piece_03.tscn")
var piece_04_factory = preload("res://minigames/explotar_globo/balloon_pieces/piece_04.tscn")
var piece_05_factory = preload("res://minigames/explotar_globo/balloon_pieces/piece_05.tscn")


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

	if clicks_needed <= 0 && !balloon_popped:
		game_cleared.emit()
		$globo.visible = false
		$WhiteLightTimer.start()
		balloon_popped = true


func _on_white_light_timer_timeout():
	var piece
	$sfx/celebration.play()
	
	for i in range(30):
		var balloon_piece = randi_range(1, 5)
		print(balloon_piece)
		if balloon_piece == 1:
			piece = piece_01_factory.instantiate()
		elif balloon_piece == 2:
			piece = piece_02_factory.instantiate()
		elif balloon_piece == 3:
			piece = piece_03_factory.instantiate()
		elif balloon_piece == 4:
			piece = piece_04_factory.instantiate()
		else:
			piece = piece_05_factory.instantiate()
		
		piece.position = $globo.position
		piece.scale = Vector2(randf_range(-1, 1), randf_range(-1, 1))
		piece.linear_velocity = Vector2.from_angle(randf_range(0, 2 * PI)) * 500 * Vector2(1, randf_range(-2.5, 0))
		piece.angular_velocity = randi_range(-20, 20)
		$PiecesContainer.add_child(piece)
	
	$WhiteLightTimer.stop()

