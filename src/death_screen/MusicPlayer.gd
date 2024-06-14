extends AudioStreamPlayer

var loopSet = false

func _on_finished():
	if !loopSet:
		self.set_stream(preload("res://death_screen/deathMusic/deathmusicloop.wav"))
		loopSet = true
	self.play()
