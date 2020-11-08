extends Node


# Тип взаимодействия с экраном
enum EInputEventScreenType { NONE = 0, TOUCH, DRAG }


# Список классов-значений для класса-параметра TouchEventStatParameters
class CurrentTypeValue:
	var m_value = EInputEventScreenType.NONE setget Set, Get
	
	func Get():
		return m_value
	
	func Set(value) -> void:
		m_value = value


class IndexValue:
	var m_value: int = 0 setget Set, Get
	
	func Get() -> int:
		return m_value
	
	func Set(value: int) -> void:
		m_value = value


class PressedValue:
	var m_value: bool = 0 setget Set, Get
	
	func Get() -> bool:
		return m_value
	
	func Set(value: bool) -> void:
		m_value = value


class PositionValue:
	var m_value: Vector2 = Vector2() setget Set, Get
	
	func Get() -> Vector2:
		return m_value
	
	func Set(value: Vector2) -> void:
		m_value = value


# Класс-параметр со списком значений для класса TouchEventStat.
# Методы этого класса используются для генерации объекта TouchEventStatParameters
# перед созданием объекта TouchEventStat
class TouchEventStatParameters:
	var m_currentType: CurrentTypeValue = CurrentTypeValue.new()
	
	var m_index: IndexValue = IndexValue.new()
	var m_pressed: PressedValue = PressedValue.new()
	var m_position: PositionValue = PositionValue.new()
	
	func SetCurrentType(currentType) -> TouchEventStatParameters:
		m_currentType.Set(currentType)
		return self
	
	func SetIndex(index: int) -> TouchEventStatParameters:
		m_index.Set(index)
		return self
	
	func SetPressed(pressed: bool) -> TouchEventStatParameters:
		m_pressed.Set(pressed)
		return self
	
	func SetPosition(pos: Vector2) -> TouchEventStatParameters:
		m_position.Set(pos)
		return self


# Класс, который хранит статистику по каждому отдельному прикосновению к экрану
class TouchEventStat:
	var m_parameters: TouchEventStatParameters = null
	
	func _init(parameters: TouchEventStatParameters = \
						   TouchEventStatParameters.new()) -> void:
		m_parameters = parameters
	
	func ResetCurrentType() -> void:
		m_parameters.SetCurrentType(EInputEventScreenType.NONE)
	
	func CurrentType() -> CurrentTypeValue:
		return m_parameters.m_currentType
	
	func Index() -> IndexValue:
		return m_parameters.m_index
	
	func Pressed() -> PressedValue:
		return m_parameters.m_pressed
	
	func Position() -> PositionValue:
		return m_parameters.m_position


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
			if touch.Pressed().Get():
				result.push_back(touch)
		
		return result


""" ### Global variables ### """

onready var current_touch := MultiTouch.new()


""" ### Godot events ### """

func _input(event):
	if event is InputEventScreenTouch:
		if (event.index < current_touch.Size()):
			current_touch.At(event.index).CurrentType().Set(EInputEventScreenType.TOUCH)
			
			if (event.is_pressed()):
				current_touch.At(event.index).Pressed().Set(true)
				current_touch.At(event.index).Position().Set(event.position)
			else:
				current_touch.At(event.index).Pressed().Set(false)
				current_touch.At(event.index).Position().Set(event.position)
	elif event is InputEventScreenDrag:
		if (event.index < current_touch.Size()):
			current_touch.At(event.index).CurrentType().Set(EInputEventScreenType.DRAG)
			current_touch.At(event.index).Position().Set(event.position)
