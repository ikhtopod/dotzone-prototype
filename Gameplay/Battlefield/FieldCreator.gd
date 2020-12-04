extends Resource

class_name FieldCreator


const BASE: int = 2
const POWER: int = 5
var MIN_SPINE: int = pow(BASE, POWER)
var MIN_FIELD: int = 1 #MIN_SPINE * POWER


var m_spine: Array = [] setget ,GetSpine
var m_field := {} setget ,GetField


func GetSpine() -> Array:
	return m_spine

func GetField() -> Dictionary:
	return m_field


func _init():
	randomize()


func Clear() -> void:
	if m_spine:
		m_spine.clear()
	
	if m_field:
		m_field.clear()


func Generate() -> void:
	GenerateSpine()
	GenerateField()
	ExtraField()


func GenerateSpine() -> void:
	m_spine.push_back(Point.new())

	for i in range(m_spine.size(), MIN_SPINE):
		PushBackRandomPointToSpine()


func GenerateField() -> void:
	for i in range(m_spine.size()):
		if not m_spine[i]:
			continue
		
		Create21(m_spine[i])
		

func ExtraField() -> void:
	if m_field and m_field.size() >= MIN_FIELD:
		return
	
	while m_field.size() < MIN_FIELD:
		PushBackRandomPointToSpine()
		Create21(m_spine.back())


func Create21(centralPoint: Point) -> void:
	for x in range(-2, 3):
		for y in range(-2, 3):
			if abs(x) == 2 and abs(y) == 2:
				continue
			
			PushToFieldIfUnique(centralPoint.Add(Point.new(x, y)))


func PushToFieldIfUnique(point: Point) -> void:
	if not m_field.has(point.ToString()):
		m_field[point.ToString()] = point


func __HasPointInArray(point: Point, points: Array) -> bool:
	if point and points:
		for p in points:
			if not p:
				continue
			
			if p.Eq(point):
				return true
	
	return false;

func HasPointInSpine(point: Point) -> bool:
	return __HasPointInArray(point, m_spine);


func GetRandomPointFromSpine() -> Point:
	if m_spine.empty():
		return null
	
	return m_spine[randi() % m_spine.size()]


func GetRandomOffset() -> int:
	return randi() % 3 - 1 # random: -1, 0 or 1


func PushBackRandomPointToSpine() -> void:
	m_spine.push_back(GetNextRandomPoint(m_spine.back()))


func GetNextRandomPoint(point: Point) -> Point:
	if point:
		while HasPointInSpine(point):
			var rndPoint: Point = GetRandomPointFromSpine()
			
			while point.Eq(rndPoint):
				point = Point.new().InitPoint(rndPoint)
				point.x += GetRandomOffset()
				point.y += GetRandomOffset()
	
	return point

