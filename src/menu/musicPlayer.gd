extends AudioStreamPlayer

var songLoop = preload("res://menu/menuSongLoop.ogg")
var loopedFlag = false


func _on_finished():
	if !loopedFlag:
		self.stream = songLoop
		loopedFlag = true
	self.play()
