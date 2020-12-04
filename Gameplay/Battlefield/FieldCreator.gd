extends Resource

class_name FieldCreator


const BASE: int = 2
const POWER: int = 5
var MIN_SPINE: int = pow(BASE, POWER)
var MIN_FIELD: int = MIN_SPINE * POWER


var m_spine: Array = [] setget ,GetSpine
var m_field: Array = [] setget ,GetField

func GetSpine() -> Array:
	return m_spine

func GetField() -> Array:
	return m_field


func Clear() -> void:
	if m_spine:
		m_spine.clear()
	
	if m_field:
		m_field.clear()


func _init():
	randomize()


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
		
		Create21(m_spine[i].ToVector2())
		

func ExtraField() -> void:
	if m_field and m_field.size() >= MIN_FIELD:
		return
	
	while m_field.size() < MIN_FIELD:
		PushBackRandomPointToSpine()
		Create21(m_spine.back().ToVector2())


func Create21(pointAsVec: Vector2) -> void:
	PushToFieldIfUnique(Point.new().InitVector2(pointAsVec))
	
	PushToFieldIfUnique(Point.new().InitVector2(pointAsVec + Vector2.UP))
	PushToFieldIfUnique(Point.new().InitVector2(pointAsVec + Vector2.UP + Vector2.LEFT))
	PushToFieldIfUnique(Point.new().InitVector2(pointAsVec + Vector2.UP + Vector2.RIGHT))
	PushToFieldIfUnique(Point.new().InitVector2(pointAsVec + Vector2.UP + Vector2.UP))
	PushToFieldIfUnique(Point.new().InitVector2(pointAsVec + Vector2.UP + Vector2.UP + Vector2.LEFT))
	PushToFieldIfUnique(Point.new().InitVector2(pointAsVec + Vector2.UP + Vector2.UP + Vector2.RIGHT))
	
	PushToFieldIfUnique(Point.new().InitVector2(pointAsVec + Vector2.DOWN))
	PushToFieldIfUnique(Point.new().InitVector2(pointAsVec + Vector2.DOWN + Vector2.LEFT))
	PushToFieldIfUnique(Point.new().InitVector2(pointAsVec + Vector2.DOWN + Vector2.RIGHT))
	PushToFieldIfUnique(Point.new().InitVector2(pointAsVec + Vector2.DOWN + Vector2.DOWN))
	PushToFieldIfUnique(Point.new().InitVector2(pointAsVec + Vector2.DOWN + Vector2.DOWN + Vector2.LEFT))
	PushToFieldIfUnique(Point.new().InitVector2(pointAsVec + Vector2.DOWN + Vector2.DOWN + Vector2.RIGHT))
	
	PushToFieldIfUnique(Point.new().InitVector2(pointAsVec + Vector2.LEFT))
	PushToFieldIfUnique(Point.new().InitVector2(pointAsVec + Vector2.LEFT + Vector2.LEFT))
	PushToFieldIfUnique(Point.new().InitVector2(pointAsVec + Vector2.LEFT + Vector2.LEFT + Vector2.DOWN))
	PushToFieldIfUnique(Point.new().InitVector2(pointAsVec + Vector2.LEFT + Vector2.LEFT + Vector2.UP))
	
	PushToFieldIfUnique(Point.new().InitVector2(pointAsVec + Vector2.RIGHT))
	PushToFieldIfUnique(Point.new().InitVector2(pointAsVec + Vector2.RIGHT + Vector2.RIGHT))
	PushToFieldIfUnique(Point.new().InitVector2(pointAsVec + Vector2.RIGHT + Vector2.RIGHT + Vector2.DOWN))
	PushToFieldIfUnique(Point.new().InitVector2(pointAsVec + Vector2.RIGHT + Vector2.RIGHT + Vector2.UP))


func PushToFieldIfUnique(point: Point) -> void:
	if not HasPointInField(point):
		m_field.push_back(point)


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

func HasPointInField(point: Point) -> bool:
	return __HasPointInArray(point, m_field);


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

