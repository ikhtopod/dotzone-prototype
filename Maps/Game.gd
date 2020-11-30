extends Node2D


onready var mainMenuSceneName: String = "res://Maps/MainMenu.tscn"

onready var mainCameraTargetNode := $CameraManager/MainCameraTarget
onready var mainCameraNode := $CameraManager/MainCamera
onready var battlefieldNode := $Battlefield

const FingerTouchScene = preload("res://Gameplay/FingerTouch/FingerTouch.tscn")


func _ready():
	TouchManager.connect("touch", self, "_TouchReaction")


func _input(event):
	if event is InputEventKey:
		if event.pressed and event.scancode == KEY_BACKSPACE:
			goto_main_menu()


func _notification(what):
	""" Нажатие на клавишу Back """
	# For Android
	if what == MainLoop.NOTIFICATION_WM_GO_BACK_REQUEST: 
		goto_main_menu()
	
	# For Windows
	if what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST:
		goto_main_menu()


func goto_main_menu():
	var result = get_tree().change_scene(mainMenuSceneName)
	
	if result != OK:
		printerr("Error: can't change scene to " + mainMenuSceneName)


# Реакция на прикосновение пальца к экрану
func _TouchReaction(index: int, touch: TouchManager.TouchEventStat):
	var finger_touch = FingerTouchScene.instance()
	finger_touch.position = \
		touch.Position().Get() + mainCameraNode.position - (get_viewport_rect().size / 2.0)
	add_child(finger_touch)
