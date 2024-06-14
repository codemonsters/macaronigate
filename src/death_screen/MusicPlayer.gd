extends AudioStreamPlayer

var loopSet = false
var songLooped = preload("res://death_screen/deathMusic/deathmusicloop.wav")

func _on_finished():
	if !loopSet:
		self.set_stream(songLooped)
		loopSet = true
	self.play()
