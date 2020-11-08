extends Position2D


signal moved


func _process(delta):
	for touch in TouchManager.current_touch.GetOnlyPressed():
		position += (touch.GetPosition() - (get_viewport_rect().size / 2.0)) * delta
		print(touch.GetCurrentType())
		emit_signal("moved")
