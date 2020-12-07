extends Node2D


onready var mainCameraTargetNode := $CameraManager/MainCameraTarget
onready var mainCameraNode := $CameraManager/MainCamera
onready var battlefieldNode := $Battlefield

const FingerTouchScene = preload("res://Gameplay/FingerTouch/FingerTouch.tscn")


func _ready():
	TouchManager.connect("touch", self, "_TouchReaction")


func _input(event):
	if event is InputEventKey:
		if event.pressed and event.scancode == KEY_BACKSPACE:
			SceneManager.GotoMainMenu()


func _notification(what):
	""" Нажатие на клавишу Back """
	# For Android
	if what == MainLoop.NOTIFICATION_WM_GO_BACK_REQUEST: 
		SceneManager.GotoMainMenu()
	
	# For Windows
	if what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST:
		SceneManager.GotoMainMenu()


func _enter_tree():
	GameManager.currenGameplayPhase = GameManager.EGameplayPhase.GAME


func _exit_tree():
	for child in get_children():
		child.queue_free()
	queue_free()


# Реакция на прикосновение пальца к экрану
func _TouchReaction(index: int, touch: TouchManager.TouchEventStat):
	var finger_touch = FingerTouchScene.instance()
	finger_touch.position = \
		touch.Position().Get() + mainCameraNode.position - (get_viewport_rect().size / 2.0)
	add_child(finger_touch)
