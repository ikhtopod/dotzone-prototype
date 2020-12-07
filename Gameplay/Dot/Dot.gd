extends Node2D


var m_point: Point = Point.new()
var m_noise: float = 0.0 setget SetNoise, GetNoise
var m_strength: float = 1.0 setget ,GetStrength
var m_color: Color = Color.darkseagreen


func Init(point: Point, noise: float):
	m_point = Point.new().InitPoint(point)
	position = m_point.ToVector2() * GameManager.DISTANCE_BETWEEN_POINTS
	SetNoise(noise)
	return self


func GetStrength() -> float:
	return m_strength

func GetNoise() -> float:
	return m_noise

func SetNoise(noise: float) -> void:
	m_noise = noise
	SetStrengthByNoise()
	SetColorByNoise()

func SetStrengthByNoise() -> void:
	m_strength = m_noise

func SetColorByNoise() -> void:
	if GetNoise() > 0.0:
		m_color = Color.darkseagreen.linear_interpolate(Color.darkred, GetNoise())
	else:
		m_color = Color.darkseagreen.linear_interpolate(Color.dodgerblue, abs(GetNoise()))
	
	$Sprite.self_modulate = m_color


func _on_Area2D_area_entered(area: Area2D):
	if not area.is_in_group("FingerTouch"):
		return
	
	# Временная хрень показывающая работоспособность прикосновений.
	# Отображает в Label из группы Dot_Printer имя объекта.
	var printer_nodes = get_tree().get_nodes_in_group("Dot_Printer")
	
	if (printer_nodes.empty()):
		return
	
	var printer_node: Label = printer_nodes.front() as Label
	printer_node.text = str(m_noise)

