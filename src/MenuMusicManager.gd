extends AudioStreamPlayer

var firstLoop

func _ready():
	firstLoop = true

func _process(delta):
	if !playing:
		if firstLoop:
			stream = load("res://menuSongLoop.ogg")
		self.play()
	
