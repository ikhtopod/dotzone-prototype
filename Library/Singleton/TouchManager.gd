extends Node


# Тип взаимодействия с экраном
enum EInputEventScreenType { NONE = 0, TOUCH, DRAG }


### Список классов-значений для класса-параметра TouchEventStatParameters ###

# Текущий тип прикосновения к экрану
class CurrentTypeValue:
	var m_value = EInputEventScreenType.NONE setget Set, Get
	
	func Get():
		return m_value
	
	func Set(value) -> void:
		m_value = value


# The drag/touch index in the case of a multi-touch event. One index = one finger.
class IndexValue:
	var m_value: int = 0 setget Set, Get
	
	func Get() -> int:
		return m_value
	
	func Set(value: int) -> void:
		m_value = value


# If true, the touch's state is pressed.
# If false, the touch's state is released.
class PressedValue:
	var m_value: bool = 0 setget Set, Get
	
	func Get() -> bool:
		return m_value
	
	func Set(value: bool) -> void:
		m_value = value


# The drag/touch position.
class PositionValue:
	var m_value: Vector2 = Vector2() setget Set, Get
	
	func Get() -> Vector2:
		return m_value
	
	func Set(value: Vector2) -> void:
		m_value = value


# The drag position relative to its start position.
class RelativeValue:
	var m_value: Vector2 = Vector2() setget Set, Get
	
	func Get() -> Vector2:
		return m_value
	
	func Set(value: Vector2) -> void:
		m_value = value


# The drag speed.
class SpeedValue:
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
	
	var m_relative: RelativeValue = RelativeValue.new()
	var m_speed: SpeedValue = SpeedValue.new()
	
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
	
	func SetRelative(revative: Vector2) -> TouchEventStatParameters:
		m_relative.Set(revative)
		return self
	
	func SetSpeed(speed: Vector2) -> TouchEventStatParameters:
		m_speed.Set(speed)
		return self


# Класс, который хранит статистику по каждому отдельному прикосновению к экрану
class TouchEventStat:
	var m_parameters: TouchEventStatParameters = null
	
	func _init(parameters: TouchEventStatParameters = \
						   TouchEventStatParameters.new()) -> void:
		m_parameters = parameters
	
	func ResetParameters() -> void:
		m_parameters = TouchEventStatParameters.new()
	
	func CurrentType() -> CurrentTypeValue:
		return m_parameters.m_currentType
	
	func Index() -> IndexValue:
		return m_parameters.m_index
	
	func Pressed() -> PressedValue:
		return m_parameters.m_pressed
	
	func Position() -> PositionValue:
		return m_parameters.m_position
	
	func Relative() -> RelativeValue:
		return m_parameters.m_relative
	
	func Speed() -> SpeedValue:
		return m_parameters.m_speed


# Класс, который хранит прикосновения к экрану,
# а также, ограничивает количество прикосновений
class MultiTouch:
	const MAX_TOUCH: int = 1
	
	var m_touch: Array = []
	
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
	
	# Можно ли обработать прикосновение по переданному индексу
	func CanHandleTouch(index: int) -> bool:
		return index < Size()
	
	# Получить массив из данных типа TouchEventStat,
	# значение pressed которых равно true
	func GetOnlyPressed() -> Array:
		var result: Array = []
		
		for touch in m_touch:
			if touch.Pressed().Get():
				result.push_back(touch)
		
		return result
	
	func __GetSome_EInputEventScreenType(type) -> Array:
		var result: Array = []
		
		for touch in m_touch:
			if touch.CurrentType().Get() == type:
				result.push_back(touch)
		
		return result
	
	# Получить массив из данных типа TouchEventStat,
	# значение CurrentType которых не равно EInputEventScreenType.NONE
	func GetOnlyNONE() -> Array:
		return __GetSome_EInputEventScreenType(EInputEventScreenType.NONE)

	# Получить массив из данных типа TouchEventStat,
	# значение CurrentType которых не равно EInputEventScreenType.TOUCH
	func GetOnlyTOUCH() -> Array:
		return __GetSome_EInputEventScreenType(EInputEventScreenType.TOUCH)

	# Получить массив из данных типа TouchEventStat,
	# значение CurrentType которых не равно EInputEventScreenType.DRAG
	func GetOnlyDRAG() -> Array:
		return __GetSome_EInputEventScreenType(EInputEventScreenType.DRAG)


""" ### Global variables ### """

onready var current_touch := MultiTouch.new()


""" ### Godot events ### """

func _input(event):
	if event is InputEventScreenTouch:
		if (current_touch.CanHandleTouch(event.index)):
			match current_touch.At(event.index).CurrentType().Get():
				EInputEventScreenType.DRAG:
					#current_touch.At(event.index).CurrentType().Set(EInputEventScreenType.NONE)
					current_touch.At(event.index).ResetParameters()
				_:
					current_touch.At(event.index).CurrentType().Set(EInputEventScreenType.TOUCH)
					current_touch.At(event.index).Position().Set(event.position)
					current_touch.At(event.index).Pressed().Set(event.is_pressed())
					current_touch.At(event.index).Relative().Set(Vector2())
					current_touch.At(event.index).Speed().Set(Vector2())
	elif event is InputEventScreenDrag:
		if (current_touch.CanHandleTouch(event.index)):
			current_touch.At(event.index).CurrentType().Set(EInputEventScreenType.DRAG)
			current_touch.At(event.index).Position().Set(event.position)
			current_touch.At(event.index).Pressed().Set(true)
			current_touch.At(event.index).Relative().Set(event.relative)
			current_touch.At(event.index).Speed().Set(event.speed)

