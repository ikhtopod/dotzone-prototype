extends Camera2D


func _on_MainCameraTarget_moved() -> void:
	position = $"../MainCameraTarget".position
