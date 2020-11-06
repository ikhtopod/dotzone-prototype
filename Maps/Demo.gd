extends Node2D


func _ready() -> void:
	var screenSize: Vector2 = get_viewport().size
	var informationLabel: Node = $"CanvasLayer/VBoxContainer/HBoxContainer/VBoxContainer/InformationLabel" as Node
	informationLabel.text = str(screenSize.x) + "x" + str(screenSize.y)
	

func _on_ExitButton_pressed() -> void:
	get_tree().quit()
