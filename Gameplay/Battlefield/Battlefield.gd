extends Node2D

# Шаблон MVC:
#     Model: DotStructure
#     View: DotView
#     Controller:
#         View to Model: DotView->ToucnManager->DotStructure
#         Model to View: DotStructure->DotView


const DotViewScene = preload("res://Gameplay/Dot/DotView.tscn")


# Модель поля
var m_field: DotStructure = null setget ,GetField

func GetField() -> DotStructure:
	return m_field


# Очистить поле
func ClearField() -> void:
	m_field.Clear()


func _ready():
	m_field = DotStructure.new()


func _exit_tree():
	ClearField()
