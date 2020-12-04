extends Resource

class_name FieldCreator


const MAX_DOTS: int = 32


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


func GenerateSpine() -> void:
	m_spine.push_back(Point.new())

	for i in range(m_spine.size(), MAX_DOTS):
		m_spine.push_back(GetNextRandomPoint(m_spine.back()))


func GenerateField() -> void:
	for i in range(m_spine.size()):
		if not m_spine[i]:
			continue
		
		var pointAsVec: Vector2 = m_spine[i].ToVector2()
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


func GetRandomPointFromQueue() -> Point:
	if m_spine.empty():
		return null
	
	return m_spine[randi() % m_spine.size()]


func GetRandomOffset() -> int:
	return randi() % 3 - 1


func GetNextRandomPoint(point: Point) -> Point:
	if point:
		while HasPointInSpine(point):
			var rndPoint: Point = GetRandomPointFromQueue()
			
			while point.Eq(rndPoint):
				point = Point.new().InitPoint(rndPoint)
				point.x += GetRandomOffset()
				point.y += GetRandomOffset()
	
	return point

