extends Node2D


onready var counter = 0

# Высота точки. От нее зависит цвет и скорость захвата
onready var height: float = 0.0
# Цвет объекта. Зависит от высоты
onready var color: Color = Color()
# Зона, частью которой является точка
onready var area = null
# Сила точки для захвата другой точки
onready var strength: float = 0.0
# Находится ли точка в стадии захвата
onready var inCapture: bool = false
# Находится ли точка в состоянии спора
onready var inContest: bool = false


func _on_Area2D_area_entered(area: Area2D):
	if not area.is_in_group("FingerTouch"):
		return
	
	var printer_nodes = get_tree().get_nodes_in_group("Dot_Printer")
	
	if (printer_nodes.empty()):
		return
	
	var printer_node: Label = printer_nodes.front() as Label
	printer_node.text = name

