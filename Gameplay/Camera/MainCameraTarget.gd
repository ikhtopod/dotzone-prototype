extends Position2D


signal moved


const SPEED_USING: float = 2500.0


func GetRelativeOffsetPosition(touch: TouchManager.TouchEventStat) -> Vector2:
	return touch.Relative().Get()


func GetSpeedOffsetPosition(delta: float, touch: TouchManager.TouchEventStat) -> Vector2:
	return GetRelativeOffsetPosition(touch) * touch.Speed().Get().abs() * pow(delta, 1.5)


func SpeedIsUsing(touch: TouchManager.TouchEventStat) -> bool:
	var speed: Vector2 = touch.Speed().Get().abs()
	return speed.x > SPEED_USING or speed.y > SPEED_USING


func _process(delta):
	var touch = TouchManager.current_touch.GetFirstDRAG()
	
	if touch:
		if SpeedIsUsing(touch):
			position -= GetSpeedOffsetPosition(delta, touch)
		else:
			position -= GetRelativeOffsetPosition(touch)
			
		emit_signal("moved")
