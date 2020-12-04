extends Resource

class_name FieldCreator


const BASE: int = 3
const POWER: int = 5
var MIN_SPINE: int = pow(BASE, POWER)
var MIN_FIELD: int = MIN_SPINE * POWER

var m_spineLastKey: String = ""
var m_fieldLastKey: String = ""

var m_spine := {} setget ,GetSpine
var m_field := {} setget ,GetField


func GetSpine() -> Dictionary:
	return m_spine

func GetField() -> Dictionary:
	return m_field

func GetLastAddedPoint() -> Point:
	if m_field.has(m_fieldLastKey):
		return m_field[m_fieldLastKey]
	
	return null


func _init():
	randomize()


func Clear() -> void:
	if m_spine:
		m_spine.clear()
	
	if m_field:
		m_field.clear()


# объекты генерируются "на лету", посредством yield()
func GenerateCoroutine() -> void:
	m_spineLastKey = Point.new().ToString()
	m_spine[m_spineLastKey] = Point.new()
	
	while m_spine.size() < MIN_SPINE and m_field.size() < MIN_FIELD:
		AddNextRandomPoint()
		
		for x in range(-2, 3):
			for y in range(-2, 3):
				if abs(x) == 2 and abs(y) == 2:
					continue
				
				# PushToFieldIfUnique()
				var point: Point = m_spine[m_spineLastKey].Add(Point.new(x, y))
				if not m_field.has(point.ToString()):
					m_fieldLastKey = point.ToString()
					m_field[m_fieldLastKey] = point
					yield()


func AddNextRandomPoint() -> String:
	var point: Point = m_spine[m_spineLastKey] 
	
	if point:
		while m_spine.has(point.ToString()):
			# GetRandomPointFromSpine()
			var rndPoint: Point = null
			if !m_spine.empty():
				rndPoint = m_spine[m_spine.keys()[randi() % m_spine.size()]]
			
			while point.Eq(rndPoint):
				point = Point.new().InitPoint(rndPoint)
				point.x += GetRandomOffset()
				point.y += GetRandomOffset()
	
	m_spineLastKey = point.ToString()
	m_spine[m_spineLastKey] = point
	
	return m_spineLastKey


func GetRandomOffset() -> int:
	return randi() % 3 - 1 # random: -1, 0 or 1
