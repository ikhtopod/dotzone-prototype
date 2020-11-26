extends Node2D


onready var mainMenuScene: String = "res://Maps/MainMenu.tscn"

onready var mainCameraTarget := $CameraManager/MainCameraTarget
onready var mainCamera := $CameraManager/MainCamera
onready var battlefield := $Battlefield

const FingerTouch = preload("res://Gameplay/FingerTouch/FingerTouch.tscn")


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
	var result = get_tree().change_scene(mainMenuScene)
	
	if result != OK:
		printerr("Error: can't change scene to " + mainMenuScene)


# Реакция на прикосновение пальца к экрану
func _TouchReaction(index, touch: TouchManager.TouchEventStat):
	var finger_touch = FingerTouch.instance()
	finger_touch.position = touch.Position().Get() + mainCameraTarget.position
	add_child(finger_touch)
