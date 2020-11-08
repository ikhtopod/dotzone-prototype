extends Node2D


onready var mainMenuScene: String = "res://Maps/MainMenu.tscn"


func goto_main_menu():
	var result = get_tree().change_scene(mainMenuScene)
	
	if result != OK:
		printerr("Error: can't change scene to " + mainMenuScene)


func _notification(what):
	""" Нажатие на клавишу Back """
	# For Android
	if what == MainLoop.NOTIFICATION_WM_GO_BACK_REQUEST: 
		goto_main_menu()
	
	# For Windows
	if what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST:
		goto_main_menu()