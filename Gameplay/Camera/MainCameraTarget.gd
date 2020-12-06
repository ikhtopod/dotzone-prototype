extends Position2D


signal moved


const SPEED_USING: float = 2500.0


func SpeedIsUsing(touch: TouchManager.TouchEventStat) -> bool:
	var speed: Vector2 = touch.Speed().Get().abs()
	return speed.x > SPEED_USING or speed.y > SPEED_USING


func RelativePositionOffset(touch: TouchManager.TouchEventStat) -> void:
	position -= touch.Relative().Get()


func LockPosition() -> void:
	position = GameManager.NormalizePositionBySides(position)


func _ready():
	var result := TouchManager.connect("drag", self, "_on_MainCameraTarget_drag")
	if result != OK:
		printerr("Can't connect method Game._on_MainCameraTarget_drag to signal TouchManager.drag")
		$"..".goto_main_menu()


# Реакция на движение пальца по экрану
func _on_MainCameraTarget_drag(index: int, touch: TouchManager.TouchEventStat) -> void:
	if !touch:
		return
	
	RelativePositionOffset(touch)
	LockPosition()
	emit_signal("moved")
