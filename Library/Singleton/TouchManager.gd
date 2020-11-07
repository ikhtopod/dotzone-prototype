extends Node


class TouchEventStat:
	var m_index: int setget SetIndex, GetIndex
	var m_pressed: bool setget SetPressed, IsPressed
	var m_position: Vector2 setget SetPosition, GetPosition
	
	func _init(index: int = 0, pressed: bool = false, position := Vector2()) -> void:
		m_index = index
		m_pressed = pressed
		m_position = position
	
	func GetIndex() -> int:
		return m_index
	
	func SetIndex(index: int) -> void:
		m_index = index
	
	func IsPressed() -> bool:
		return m_pressed
	
	func SetPressed(pressed: bool) -> void:
		m_pressed = pressed
	
	func GetPosition() -> Vector2:
		return m_position
	
	func SetPosition(position: Vector2) -> void:
		m_position = position


# Класс, который хранит прикосновения к экрану,
# а также, ограничивает количество прикосновений
class MultiTouch:
	const MAX_TOUCH: int = 1
	
	var m_touch: Array
	
	func _init() -> void:
		for index in range(MAX_TOUCH):
			m_touch.push_back(TouchEventStat.new(index))
	
	# Получить размер внутреннего массива MultiTouch
	func Size() -> int:
		return m_touch.size()
	
	# Получить TouchEventStat по индексу
	func At(var index: int) -> TouchEventStat:
		if index < 0 or index >= self.Size():
			return null
		
		return m_touch[index]
	
	# Получить массив из данных типа TouchEventStat,
	# значение pressed которых равно true
	func GetOnlyPressed() -> Array:
		var result: Array = []
		
		for touch in m_touch:
			if touch.IsPressed():
				result.push_back(touch)
		
		return result


""" ### Global variables ### """

onready var current_touch := MultiTouch.new()


""" ### Godot events ### """

func _input(event):
	if event is InputEventScreenTouch:
		if (event.index < current_touch.Size()):
			if (event.is_pressed()):
				current_touch.At(event.index).SetPressed(true)
				current_touch.At(event.index).SetPosition(event.position)
			else:
				current_touch.At(event.index).SetPressed(false)
	elif event is InputEventScreenDrag:
		if (event.index < current_touch.Size()):
			current_touch.At(event.index).SetPosition(event.position)
