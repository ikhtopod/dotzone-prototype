extends Node2D


onready var gameScene: String = "res://Maps/Game.tscn"

func _ready():
	var screenSize: Vector2 = get_viewport_rect().size
	var informationLabel: Node = $"CanvasLayer/VBoxContainer/HBoxContainer/VBoxContainer/InformationLabel" as Node
	informationLabel.text = str(screenSize.x) + "x" + str(screenSize.y)
	

func _on_ExitButton_pressed():
	get_tree().quit()


func _on_StartButton_pressed():
	var res := get_tree().change_scene(gameScene)
	
	if res != OK:
		printerr("Can't change scene to " + gameScene)
