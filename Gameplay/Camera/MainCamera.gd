extends Camera2D


onready var mainCameraTargetNode: Node = $"../MainCameraTarget"

func _on_MainCameraTarget_moved() -> void:
	position = mainCameraTargetNode.position
