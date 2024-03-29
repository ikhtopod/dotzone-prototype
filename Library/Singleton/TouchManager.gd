extends Node


# Реакция на InputEventScreenDrag
# index - номер прикосновения
# touch - объект типа TouchEventStat
signal drag(index, touch)

# Реакция на InputEventScreenTouch
# index - номер прикосновения
# touch - объект типа TouchEventStat
signal touch(index, touch)


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
	const DEFAULT_MAX_TOUCH: int = 10
	var m_currentMaxTouch: int = DEFAULT_MAX_TOUCH setget SetCurrentMaxTouch
	
	var m_touch: Array = []
	
	func _init(maxTouch: int = 0) -> void:
		SetCurrentMaxTouch(maxTouch)
		InitTouch()
	
	# Изменить значение поля m_currentMaxTouch с учетном ограничений
	func SetCurrentMaxTouch(maxTouch: int) -> void:
		if maxTouch > 0 and maxTouch < DEFAULT_MAX_TOUCH:
			m_currentMaxTouch = maxTouch
	
	# Инициализация поля m_touch
	func InitTouch() -> void:
		for index in range(m_currentMaxTouch):
			var tmpParams: TouchEventStatParameters = \
				TouchEventStatParameters.new().SetIndex(index)
			m_touch.push_back(TouchEventStat.new(tmpParams))
	
	# Получить размер внутреннего массива MultiTouch
	func Size() -> int:
		return m_touch.size()
	
	# Получить TouchEventStat по индексу
	func At(var index: int) -> TouchEventStat:
		if index < 0 or not CanHandleTouch(index):
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
	
	# Вспомогательная функция для функций начинающихся с 
	# префикса GetOnly***()
	func __GetSomeByEInputEventScreenType(type) -> Array:
		var result: Array = []
		
		for touch in m_touch:
			if touch.CurrentType().Get() == type:
				result.push_back(touch)
		
		return result
	
	# Получить массив из данных типа TouchEventStat,
	# значение CurrentType которых равно EInputEventScreenType.NONE
	func GetOnlyNONE() -> Array:
		return __GetSomeByEInputEventScreenType(EInputEventScreenType.NONE)

	# Получить массив из данных типа TouchEventStat,
	# значение CurrentType которых равно EInputEventScreenType.TOUCH
	func GetOnlyTOUCH() -> Array:
		return __GetSomeByEInputEventScreenType(EInputEventScreenType.TOUCH)

	# Получить массив из данных типа TouchEventStat,
	# значение CurrentType которых равно EInputEventScreenType.DRAG
	func GetOnlyDRAG() -> Array:
		return __GetSomeByEInputEventScreenType(EInputEventScreenType.DRAG)
	
	# Вспомогательная функция для функций начинающихся с 
	# префикса GetFirst***()
	func __GetFirstByEInputEventScreenType(type) -> TouchEventStat:
		for touch in m_touch:
			if touch.CurrentType().Get() == type:
				return touch
		
		return null
	
	# Получить первый объект типа TouchEventStat,
	# значение CurrentType которого равно EInputEventScreenType.TOUCH
	# Если таких объектов нет, то вернуть null
	func GetFirstTOUCH() -> TouchEventStat:
		return __GetFirstByEInputEventScreenType(EInputEventScreenType.TOUCH)

	# Получить первый объект типа TouchEventStat,
	# значение CurrentType которого равно EInputEventScreenType.DRAG
	# Если таких объектов нет, то вернуть null
	func GetFirstDRAG() -> TouchEventStat:
		return __GetFirstByEInputEventScreenType(EInputEventScreenType.DRAG)


""" ### Global variables ### """

const MAX_NUMBER_TOUCH: int = 1
onready var current_touch := MultiTouch.new(MAX_NUMBER_TOUCH)


""" ### Godot events ### """

func IsCorrectTouchEvent(event: InputEvent) -> bool:
	return event is InputEventScreenTouch and \
		   not event.is_pressed() and \
		   current_touch.CanHandleTouch(event.index)


func IsCorrectDragEvent(event: InputEvent) -> bool:
	return event is InputEventScreenDrag


func _input(event):
	if IsCorrectTouchEvent(event):
		if current_touch.At(event.index).CurrentType().Get() == EInputEventScreenType.DRAG:
			current_touch.At(event.index).ResetParameters()
		else:
			current_touch.At(event.index).CurrentType().Set(EInputEventScreenType.TOUCH)
			current_touch.At(event.index).Position().Set(event.position)
			current_touch.At(event.index).Pressed().Set(event.is_pressed())
			current_touch.At(event.index).Relative().Set(Vector2())
			current_touch.At(event.index).Speed().Set(Vector2())
			emit_signal("touch", event.index, current_touch.At(event.index))
			get_tree().set_input_as_handled()
	elif IsCorrectDragEvent(event):
		if (current_touch.CanHandleTouch(event.index)):
			current_touch.At(event.index).CurrentType().Set(EInputEventScreenType.DRAG)
			current_touch.At(event.index).Position().Set(event.position)
			current_touch.At(event.index).Pressed().Set(true)
			current_touch.At(event.index).Relative().Set(event.relative)
			current_touch.At(event.index).Speed().Set(event.speed)
			emit_signal("drag", event.index, current_touch.At(event.index))
		else:
			get_tree().set_input_as_handled()

