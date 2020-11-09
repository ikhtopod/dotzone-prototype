extends Camera2D


onready var mainCameraTarget: Node = $"../MainCameraTarget"

func _on_MainCameraTarget_moved() -> void:
	position = mainCameraTarget.position
