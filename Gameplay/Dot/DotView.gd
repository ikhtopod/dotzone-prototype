extends Dot


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

