# Macarronigate: Il Spantosso Caso del Vitello Rubato

## Minigame integration
Sample main script (attached to main.tscn inside the minigame subfolder)
```gdscript
extends Node2D
# Declare the required signals
signal game_over
signal game_cleared

# Required variables
@export var game_brief = "Brief Game Explanation/Title!"
@export var needs_timer = true # False if your game doesn't need a countdown timer
@export var timer_seconds = 5 # Only set if needs_timer = true

func _ready():
    # Connect the appropriate signals to the funtions in game.gd
    game_over.connect(Callable(get_parent(), "on_game_over"))
    game_cleared.connect(Callable(get_parent(), "on_game_cleared"))

# When the game timer (if enabled) times out, the "on_game_timeout" function is triggered on your script
func on_game_timeout():
    emit_signal("game_cleared") # In this example the game is cleared if the player survived
```
Now, according to your game logic, you can send ```game_over``` and ```game_cleared```as appropriate.
```gdscript
emit_signal("game_over")
emit_signal("game_cleared")
```
For developing, inside ```game.gd```, set ```launch_minigame_directly``` to the name of your minigame's subfolder, and then start the project normally using F5
```gdscript
# game.gd example:
var launch_minigame_directly = null # The game will start normally to the menu
var launch_minigame_directly = "esquivar.coches" # The minigame inside "esquivar.coches" will be directly launched
# Don't forget to change the flag back before comitting!

# Array with the name of the minigames that will be played
var minigames = ["frutas", "esquivar.coches"]
```
