extends Node2D


var m_point: Point = Point.new()
var m_strength: float = 1.0
var m_color: Color = Color()


func Init(point: Point):
	m_point = Point.new().InitPoint(point)
	position = m_point.ToVector2() * GameManager.DISTANCE_BETWEEN_POINTS
	return self


func _on_Area2D_area_entered(area: Area2D):
	if not area.is_in_group("FingerTouch"):
		return
	
	# Временная хрень показывающая работоспособность прикосновений.
	# Отображает в Label из группы Dot_Printer имя объекта.
	var printer_nodes = get_tree().get_nodes_in_group("Dot_Printer")
	
	if (printer_nodes.empty()):
		return
	
	var printer_node: Label = printer_nodes.front() as Label
	printer_node.text = name

