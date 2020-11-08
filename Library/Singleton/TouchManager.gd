extends Node


enum EInputEventScreenType { NONE = 0, TOUCH, DRAG }


class TouchEventStatParameters:
	var m_currentType = EInputEventScreenType.NONE
	
	var m_index: int = 0
	var m_pressed: bool = false
	var m_position: Vector2 = Vector2()
	
	func SetCurrentType(currentType) -> TouchEventStatParameters:
		m_currentType = currentType
		return self
	
	func SetIndex(index: int) -> TouchEventStatParameters:
		m_index = index
		return self
	
	func SetPressed(pressed: bool) -> TouchEventStatParameters:
		m_pressed = pressed
		return self
	
	func SetPosition(position: Vector2) -> TouchEventStatParameters:
		m_position = position
		return self


class TouchEventStat:
	var m_parameters: TouchEventStatParameters = null
	
	func _init(parameters: TouchEventStatParameters) -> void:
		m_parameters = parameters
	
	func GetCurrentType():
		return m_parameters.m_currentType
	
	func SetCurrentType(newType) -> void:
		m_parameters.SetCurrentType(newType)
		
	func ResetCurrentType() -> void:
		m_parameters.SetCurrentType(EInputEventScreenType.NONE)
	
	func GetIndex() -> int:
		return m_parameters.m_index
	
	func SetIndex(index: int) -> void:
		m_parameters.SetIndex(index)
	
	func IsPressed() -> bool:
		return m_parameters.m_pressed
	
	func SetPressed(pressed: bool) -> void:
		m_parameters.SetPressed(pressed)
	
	func GetPosition() -> Vector2:
		return m_parameters.m_position
	
	func SetPosition(position: Vector2) -> void:
		m_parameters.SetPosition(position)


# Класс, который хранит прикосновения к экрану,
# а также, ограничивает количество прикосновений
class MultiTouch:
	const MAX_TOUCH: int = 1
	
	var m_touch: Array
	
	func _init() -> void:
		for index in range(MAX_TOUCH):
			var tmpParams: TouchEventStatParameters = \
				TouchEventStatParameters.new().SetIndex(index)
			m_touch.push_back(TouchEventStat.new(tmpParams))
	
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
			current_touch.At(event.index).SetCurrentType(EInputEventScreenType.TOUCH)
			
			if (event.is_pressed()):
				current_touch.At(event.index).SetPressed(true)
				current_touch.At(event.index).SetPosition(event.position)
			else:
				current_touch.At(event.index).SetPressed(false)
				current_touch.At(event.index).SetPosition(event.position)
	elif event is InputEventScreenDrag:
		if (event.index < current_touch.Size()):
			current_touch.At(event.index).SetCurrentType(EInputEventScreenType.DRAG)
			current_touch.At(event.index).SetPosition(event.position)
