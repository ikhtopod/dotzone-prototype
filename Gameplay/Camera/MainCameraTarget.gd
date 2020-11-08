extends Position2D


signal moved


func _process(delta):
	for touch in TouchManager.current_touch.GetOnlyDRAG():
		position -= touch.Relative().Get() * touch.Speed().Get().abs() * pow(delta, 1.5)
		emit_signal("moved")
