extends Position2D


signal moved


func _process(delta):
	for touch in TouchManager.current_touch.GetOnlyDRAG():
		position += touch.Relative().Get() * touch.Speed().Get().abs() * pow(delta, 1.8)
		#touch.ResetParameters()
		emit_signal("moved")
