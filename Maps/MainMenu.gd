extends Node2D


func _ready():
	GameManager.currenGameplayPhase = GameManager.EGameplayPhase.MAIN_MENU
	
	var screenSize: Vector2 = get_viewport_rect().size
	var informationLabel: Node = \
		$"CanvasLayer/VBoxContainer/HBoxContainer/VBoxContainer/InformationLabel" as Node
	informationLabel.text = str(screenSize.x) + "x" + str(screenSize.y)


func _on_ExitButton_pressed():
	SceneManager.QuitGame()


func _on_StartButton_pressed():
	SceneManager.GotoGame()


func _notification(what):
	""" Нажатие на клавишу Back """
	# For Android
	if what == MainLoop.NOTIFICATION_WM_GO_BACK_REQUEST: 
		SceneManager.QuitGame()
	
	# For Windows
	if what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST:
		SceneManager.QuitGame()
