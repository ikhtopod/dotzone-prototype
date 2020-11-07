extends Position2D


signal moved


const STEP: float = 200.0
var stepOffset: float = 1.0

onready var isMoved: bool = false


func get_shift_position(delta: float) -> float:
	return STEP * delta * stepOffset


func _process(delta: float) -> void:
	if Input.is_action_pressed("ui_right"):
		position.x += get_shift_position(delta)
		isMoved = true
	if Input.is_action_pressed("ui_left"):
		position.x -= get_shift_position(delta)
		isMoved = true
	if Input.is_action_pressed("ui_up"):
		position.y -= get_shift_position(delta)
		isMoved = true
	if Input.is_action_pressed("ui_down"):
		position.y += get_shift_position(delta)
		isMoved = true
	
	if isMoved:
		emit_signal("moved")
		isMoved = false
