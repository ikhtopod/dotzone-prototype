extends Node2D

const Dot = preload("res://Gameplay/Dot/Dot.tscn")


const DEFAULT_FIELD_SIZE: float = 1.0

# Текущий размер поля
var m_fieldSize: Vector2 = Vector2() setget SetFieldSize, GetFieldSize

func GetFieldSize() -> Vector2:
	return m_fieldSize

func SetFieldSize(fieldSize: Vector2) -> void:
	m_fieldSize.x = fieldSize.x if fieldSize.x else DEFAULT_FIELD_SIZE
	m_fieldSize.y = fieldSize.y if fieldSize.y else DEFAULT_FIELD_SIZE


# Поле битвы
var m_field: Array = [] setget ,GetField

# Получить поле битвы
func GetField() -> Array:
	return m_field

# Инициализировать m_field в соответствии с m_fieldSize, если поле еще не инициализировано
func InitFieldByFieldSize() -> void:
	if not m_field.empty():
		return
	
	for w in range(m_fieldSize.x):
		m_field.push_back([])
		for h in range(m_fieldSize.y):
			m_field.back().push_back(Dot.instance())
			m_field.back().back().position = Vector2(w * 128.0, h * 128.0)
			add_child(m_field.back().back())


# Сгенерировать поле битвы, если оно пустое
func Generate() -> void:
	if not m_field.empty():
		return
	
	SetFieldSize(Vector2(50, 50))
	InitFieldByFieldSize()


func _enter_tree():
	Generate()


func _ready():
	pass
