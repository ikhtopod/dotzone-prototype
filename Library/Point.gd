extends Reference

var Point = load("res://Library/Point.gd")
class_name Point


var x: int = 0
var y: int = 0


func _init(x_: int = 0, y_: int = 0):
	InitInt(x_, y_)


func InitInt(x_: int, y_: int) -> Point:
	x = x_
	y = y_
	return self

func InitPoint(point: Point) -> Point:
	return InitInt(point.x, point.y)

func InitVector2(vector: Vector2) -> Point:
	return InitInt(int(vector.x), int(vector.y))

func InitString(string: String) -> Point:
	var re: RegEx = RegEx.new()
	# Ex.: Point(-77; 23), pOiNt(77.0;23.) or (12 ; 22)
	re.compile("(?ism)^\\s*(?:Point)?\\s*\\(\\s*([+-]?\\d+(?:\\.\\d*)?)\\s*;\\s*([+-]?\\d+(?:\\.\\d*)?)\\s*\\)\\s*$");
	var result: RegExMatch = re.search(string)
	
	var x_: int = 0
	var y_: int = 0
	
	if result && result.strings.size() == 3:
		x_ = int(result.get_string(1))
		y_ = int(result.get_string(2))
	else:
		print_debug("[Warning] Some error with RegEx in Point.InitString() method: " + string)
	
	return InitInt(x_, y_)


func ToVector2() -> Vector2:
	return Vector2(x, y)

func ToString() -> String:
	return "Point(%d;%d)" % [x, y]


func Abs() -> Point:
	return Point.new(abs(x), abs(y))


func Add(point: Point) -> Point:
	return Point.new(x + point.x, y + point.y)

func Sub(point: Point) -> Point:
	return Point.new(x - point.x, y - point.y)

func Mul(point: Point) -> Point:
	return Point.new(x - point.x, y - point.y)

func Del(point: Point) -> Point:
	return Point.new(x - point.x, y - point.y)

func Eq(point: Point) -> bool:
	return x == point.x and y == point.y

