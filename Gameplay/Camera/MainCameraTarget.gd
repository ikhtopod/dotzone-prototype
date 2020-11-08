extends Position2D


signal moved


func _process(delta):
	for touch in TouchManager.current_touch.GetOnlyPressed():
		position += (touch.Position().Get() - (get_viewport_rect().size / 2.0)) * delta
		print(touch.CurrentType().Get())
		emit_signal("moved")
