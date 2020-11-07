extends Node2D


onready var gameScene: PackedScene = preload("res://Maps/Game.tscn")

func _ready() -> void:
	var screenSize: Vector2 = get_viewport_rect().size
	var informationLabel: Node = $"CanvasLayer/VBoxContainer/HBoxContainer/VBoxContainer/InformationLabel" as Node
	informationLabel.text = str(screenSize.x) + "x" + str(screenSize.y)
	

func _on_ExitButton_pressed() -> void:
	for scene in get_children():
		scene.queue_free()
	
	yield(get_tree().create_timer(1.0, false), "timeout")
	
	get_tree().quit()


func _on_StartButton_pressed() -> void:
	var res := get_tree().change_scene_to(gameScene)
	
	if res != OK:
		printerr("Cannot change scene")
