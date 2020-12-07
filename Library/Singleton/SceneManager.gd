extends Node


### Scene Name ###
onready var mainMenuSceneName: String = "res://Maps/MainMenu.tscn"
onready var gameSceneName: String = "res://Maps/Game.tscn"

### Go to Scene ###
func GotoSomeScene(sceneName: String) -> void:
	var result = get_tree().change_scene(sceneName)
	
	if result != OK:
		print_debug("[Error] Can't change scene to " + sceneName)

func GotoMainMenu():
	GotoSomeScene(mainMenuSceneName)

func GotoGame():
	GotoSomeScene(gameSceneName)


### Special Functions ###
func QuitGame() -> void:
	get_tree().quit()
