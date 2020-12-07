extends Node

### В этом скрипте хранится информация о игровом процессе ###


# Индикатор захвата территории
# Список игроков


# Расстояние между точками
const DISTANCE_BETWEEN_POINTS: float = 72.0

### Tags ###
const PLAYER_TAG: String = "Player"
const ENEMY_TAG: String = "Enemy"
const FINGER_TOUCH_TAG: String = "FingerTouch"


### Selection ###

# Сигналы для функционала, который должен возникать, если произошло
# выделение и\или развыделение объекта
signal select(object)
signal deselect(object)

var selectedObject = null setget SetSelectedObject, GetSelectedObject

# Объект, который можно выделить, должен реализовать у себя
# функции Select() и Deselect()
func SetSelectedObject(newObject) -> void:
	if newObject == selectedObject:
		return
	
	if newObject:
		if selectedObject:
			selectedObject.Deselect()
			emit_signal("deselect", selectedObject)
		
		selectedObject = newObject
		selectedObject.Select()
		emit_signal("select", selectedObject)
	else:
		if selectedObject:
			selectedObject.Deselect()
			emit_signal("deselect", selectedObject)
			selectedObject = null

func GetSelectedObject():
	return selectedObject

func ResetSelectedObject() -> void:
	SetSelectedObject(null)


###################
enum EGameplayPhase {
	UNKNOWN,
	MAIN_MENU,
	GENERATE,
	GAME,
	GAMEOFF,
}

var currenGameplayPhase = EGameplayPhase.UNKNOWN
###################

# Сброс игрового процесса. Например, при выходе из игры
func Reset() -> void:
	ResetMinMaxCoordinatesOfSides()
	currenGameplayPhase = EGameplayPhase.UNKNOWN

###################
# Наибольшая позиция влево, вправо, вверх и вних
var __mostLeft:  float = 0.0 setget SetMostLeft,  GetMostLeft
var __mostRight: float = 0.0 setget SetMostRight, GetMostRight
var __mostUp:    float = 0.0 setget SetMostUp,    GetMostUp
var __mostDown:  float = 0.0 setget SetMostDown,  GetMostDown

func SetMostLeft(value: float) -> void:
	__mostLeft = value

func GetMostLeft() -> float:
	return __mostLeft

func SetMostRight(value: float) -> void:
	__mostRight = value

func GetMostRight() -> float:
	return __mostRight

func SetMostUp(value: float) -> void:
	__mostUp = value

func GetMostUp() -> float:
	return __mostUp

func SetMostDown(value: float) -> void:
	__mostDown = value

func GetMostDown() -> float:
	return __mostDown

func AssignMinMaxCoordinatesOfSides(coord: Vector2) -> void:
	if coord.x > GetMostUp():
		SetMostUp(coord.x)
	elif coord.x < GetMostDown():
		SetMostDown(coord.x)
	
	if coord.y > GetMostRight():
		SetMostRight(coord.y)
	elif coord.y < GetMostLeft():
		SetMostLeft(coord.y)

func NormalizePositionBySides(pos: Vector2) -> Vector2:
	if pos.x > GameManager.GetMostUp():
		pos.x = GameManager.GetMostUp()
	elif pos.x < GameManager.GetMostDown():
		pos.x = GameManager.GetMostDown()
	
	if pos.y > GameManager.GetMostRight():
		pos.y = GameManager.GetMostRight()
	elif pos.y < GameManager.GetMostLeft():
		pos.y = GameManager.GetMostLeft()
	
	return pos

func ResetMinMaxCoordinatesOfSides() -> void:
	SetMostUp(0.0)
	SetMostDown(0.0)
	SetMostLeft(0.0)
	SetMostRight(0.0)
###################
