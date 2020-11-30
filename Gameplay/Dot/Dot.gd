extends Node2D

class_name Dot


"""Класс, описывающий точку - ее текущее состояние, принадлежность и т.д."""


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
