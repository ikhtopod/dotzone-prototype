extends Node2D

# Шаблон MVC:
#     Model: DotStructure
#     View: DotView
#     Controller: Battlefield, ToucnManager


const DotViewScene: PackedScene = preload("res://Gameplay/Dot/DotView.tscn")


# Модель поля
var m_field: DotStructure = null setget ,GetField

func GetField() -> DotStructure:
	return m_field


func _ready():
	m_field = DotStructure.new()
	SimpleShowDots()


func SimpleShowDots() -> void:
	if !m_field.GetRoot():
		return
	
	add_child(DotViewScene.instance().Init(m_field.GetRoot()))
	m_field.GetRoot().isChecked = true
	
	var rootDotNeighbours: Dot.DotNeighbours = m_field.GetRoot().GetDotNeighbours()
	if !rootDotNeighbours:
		return
	
	var queue: Array = [rootDotNeighbours]
	
	var counter: int = 0
	var maxDotView: int = int(pow(m_field.m_halfSize, 2) - 1) + 10000
	while !queue.empty() and counter < maxDotView:
		var dotNeighbours: Dot.DotNeighbours = queue.pop_front()
		
		if !dotNeighbours:
			continue
		
		for dot in dotNeighbours.GetNeighbours():
			if dot && !dot.isChecked:
				var newDotNeighbours: Dot.DotNeighbours = dot.GetDotNeighbours()
				if newDotNeighbours:
					queue.push_back(newDotNeighbours)
				
				add_child(DotViewScene.instance().Init(dot))
				dot.isChecked = true
				counter += 1
				if counter >= maxDotView:
					break


# Очистить поле
func ClearField() -> void:
	m_field.Clear()


func _exit_tree():
	ClearField()
