extends Resource

#Класс, описывающий точку - ее текущее состояние, принадлежность и т.д.
class_name Dot


# Стороны света (по часовой стрелке)
enum ECardinalPoints {
	N,  # Север
	NE, # Северо-Восток
	E,  # Восток
	SE, # Юго-Восток
	S,  # Юг
	SW, # Юго-Запад
	W,  # Запад
	NW, # Северо-запад
}

# Противоположные стороны света
enum EOppositeCardinalPoints {
	N = ECardinalPoints.S,   # Север (становится Юг)
	NE = ECardinalPoints.SW, # Северо-Восток (становится Юго-Запад)
	E = ECardinalPoints.W,   # Восток (становится Запад)
	SE = ECardinalPoints.NW, # Юго-Восток (становится Северо-Запад)
	S = ECardinalPoints.N,   # Юг (становится Север)
	SW = ECardinalPoints.NE, # Юго-Запад (становится Северо-Восток)
	W = ECardinalPoints.E,   # Запад (становится Восток)
	NW = ECardinalPoints.SE, # Северо-запад (становится Юго-Восток)
}


# Класс для описания соседей
class DotNeighbours extends Resource:
	# Список соседних точек
	var m_neighbours: Array = \
		[ null, null, null, null, 
		  null, null, null, null ] setget ,GetNeighbours

	func GetNeighbours() -> Array:
		return m_neighbours.duplicate(false)
	
	### North ###

	# Получить соседний объект по направлению к N
	func GetN() -> Dot:
		return m_neighbours[ECardinalPoints.N]

	# Изменить соседний объект по направлению к N
	func SetN(neighbour: Dot) -> void:
		m_neighbours[ECardinalPoints.N] = neighbour

	# Получить соседний объект по направлению противоположному относительно N
	func OppositeN() -> Dot:
		return m_neighbours[EOppositeCardinalPoints.N]

	# Изменить соседний объект по направлению противоположному относительно N
	func SetOppositeN(neighbour: Dot) -> void:
		m_neighbours[EOppositeCardinalPoints.N] = neighbour

	### South ###

	# Получить соседний объект по направлению к S
	func GetS() -> Dot:
		return m_neighbours[ECardinalPoints.S]

	# Изменить соседний объект по направлению к S
	func SetS(neighbour: Dot) -> void:
		m_neighbours[ECardinalPoints.S] = neighbour

	# Получить соседний объект по направлению противоположному относительно S
	func OppositeS() -> Dot:
		return m_neighbours[EOppositeCardinalPoints.S]

	# Изменить соседний объект по направлению противоположному относительно S
	func SetOppositeS(neighbour: Dot) -> void:
		m_neighbours[EOppositeCardinalPoints.S] = neighbour

	### West ###

	# Получить соседний объект по направлению к W
	func GetW() -> Dot:
		return m_neighbours[ECardinalPoints.W]

	# Изменить соседний объект по направлению к W
	func SetW(neighbour: Dot) -> void:
		m_neighbours[ECardinalPoints.W] = neighbour

	# Получить соседний объект по направлению противоположному относительно W
	func OppositeW() -> Dot:
		return m_neighbours[EOppositeCardinalPoints.W]

	# Изменить соседний объект по направлению противоположному относительно W
	func SetOppositeW(neighbour: Dot) -> void:
		m_neighbours[EOppositeCardinalPoints.W] = neighbour

	### East ###

	# Получить соседний объект по направлению к E
	func GetE() -> Dot:
		return m_neighbours[ECardinalPoints.E]

	# Изменить соседний объект по направлению к E
	func SetE(neighbour: Dot) -> void:
		m_neighbours[ECardinalPoints.E] = neighbour

	# Получить соседний объект по направлению противоположному относительно E
	func OppositeE() -> Dot:
		return m_neighbours[EOppositeCardinalPoints.E]

	# Изменить соседний объект по направлению противоположному относительно E
	func SetOppositeE(neighbour: Dot) -> void:
		m_neighbours[EOppositeCardinalPoints.E] = neighbour

	### Northwest ###

	# Получить соседний объект по направлению к NW
	func GetNW() -> Dot:
		return m_neighbours[ECardinalPoints.NW]

	# Изменить соседний объект по направлению к NW
	func SetNW(neighbour: Dot) -> void:
		m_neighbours[ECardinalPoints.NW] = neighbour

	# Получить соседний объект по направлению противоположному относительно NW
	func OppositeNW() -> Dot:
		return m_neighbours[EOppositeCardinalPoints.NW]

	# Изменить соседний объект по направлению противоположному относительно NW
	func SetOppositeNW(neighbour: Dot) -> void:
		m_neighbours[EOppositeCardinalPoints.NW] = neighbour

	### Northeast ###

	# Получить соседний объект по направлению к NE
	func GetNE() -> Dot:
		return m_neighbours[ECardinalPoints.NE]

	# Изменить соседний объект по направлению к NE
	func SetNE(neighbour: Dot) -> void:
		m_neighbours[ECardinalPoints.NE] = neighbour

	# Получить соседний объект по направлению противоположному относительно NE
	func OppositeNE() -> Dot:
		return m_neighbours[EOppositeCardinalPoints.NE]

	# Изменить соседний объект по направлению противоположному относительно NE
	func SetOppositeNE(neighbour: Dot) -> void:
		m_neighbours[EOppositeCardinalPoints.NE] = neighbour

	### Southwest ###

	# Получить соседний объект по направлению к SW
	func GetSW() -> Dot:
		return m_neighbours[ECardinalPoints.SW]

	# Изменить соседний объект по направлению к SW
	func SetSW(neighbour: Dot) -> void:
		m_neighbours[ECardinalPoints.SW] = neighbour

	# Получить соседний объект по направлению противоположному относительно SW
	func OppositeSW() -> Dot:
		return m_neighbours[EOppositeCardinalPoints.SW]

	# Изменить соседний объект по направлению противоположному относительно SW
	func SetOppositeSW(neighbour: Dot) -> void:
		m_neighbours[EOppositeCardinalPoints.SW] = neighbour

	### Southeast ###

	# Получить соседний объект по направлению к SE
	func GetSE() -> Dot:
		return m_neighbours[ECardinalPoints.SE]

	# Изменить соседний объект по направлению к SE
	func SetSE(neighbour: Dot) -> void:
		m_neighbours[ECardinalPoints.SE] = neighbour

	# Получить соседний объект по направлению противоположному относительно SE
	func OppositeSE() -> Dot:
		return m_neighbours[EOppositeCardinalPoints.SE]

	# Изменить соседний объект по направлению противоположному относительно SE
	func SetOppositeSE(neighbour: Dot) -> void:
		m_neighbours[EOppositeCardinalPoints.SE] = neighbour
### End DotNeighbours ###


var m_dotNeighbours: DotNeighbours = null setget ,GetDotNeighbours
var m_position: Vector2 = Vector2() setget SetPosition, GetPosition


func _init():
	m_dotNeighbours = DotNeighbours.new()


func GetDotNeighbours() -> DotNeighbours:
		return m_dotNeighbours


func GetPosition() -> Vector2:
	return m_position

func SetPosition(position: Vector2) -> void:
	m_position = position


### UpdateNeighbours ###

# Обновить соседние точки на N, общие как для точки на N так и для текущей точки.
# Аналогично для всех функций UpdateNeighbour*()

func UpdateNeighbourN() -> void:
	var neighbour = m_dotNeighbours.GetN().GetDotNeighbours()
	neighbour.SetOppositeN(self)
	neighbour.SetW(m_dotNeighbours.GetNW())
	neighbour.SetE(m_dotNeighbours.GetNE())
	neighbour.SetSW(m_dotNeighbours.GetW())
	neighbour.SetSE(m_dotNeighbours.GetE())

func UpdateNeighbourNE() -> void:
	var neighbour = m_dotNeighbours.GetNE().GetDotNeighbours()
	neighbour.SetOppositeNE(self)
	neighbour.SetW(m_dotNeighbours.GetN())
	neighbour.SetS(m_dotNeighbours.GetE())

func UpdateNeighbourE() -> void:
	var neighbour = m_dotNeighbours.GetE().GetDotNeighbours()
	neighbour.SetOppositeE(self)
	neighbour.SetN(m_dotNeighbours.GetNE())
	neighbour.SetS(m_dotNeighbours.GetSE())
	neighbour.SetNW(m_dotNeighbours.GetN())
	neighbour.SetSW(m_dotNeighbours.GetS())

func UpdateNeighbourSE() -> void:
	var neighbour = m_dotNeighbours.GetSE().GetDotNeighbours()
	neighbour.SetOppositeSE(self)
	neighbour.SetN(m_dotNeighbours.GetE())
	neighbour.SetW(m_dotNeighbours.GetS())

func UpdateNeighbourS() -> void:
	var neighbour = m_dotNeighbours.GetS().GetDotNeighbours()
	neighbour.SetOppositeS(self)
	neighbour.SetW(m_dotNeighbours.GetSW())
	neighbour.SetE(m_dotNeighbours.GetSE())
	neighbour.SetNW(m_dotNeighbours.GetW())
	neighbour.SetNE(m_dotNeighbours.GetE())

func UpdateNeighbourSW() -> void:
	var neighbour = m_dotNeighbours.GetSW().GetDotNeighbours()
	neighbour.SetOppositeSW(self)
	neighbour.SetN(m_dotNeighbours.GetW())
	neighbour.SetE(m_dotNeighbours.GetS())

func UpdateNeighbourW() -> void:
	var neighbour = m_dotNeighbours.GetW().GetDotNeighbours()
	neighbour.SetOppositeW(self)
	neighbour.SetN(m_dotNeighbours.GetNW())
	neighbour.SetS(m_dotNeighbours.GetSW())
	neighbour.SetNE(m_dotNeighbours.GetN())
	neighbour.SetSE(m_dotNeighbours.GetS())

func UpdateNeighbourNW() -> void:
	var neighbour = m_dotNeighbours.GetNW().GetDotNeighbours()
	neighbour.SetOppositeW(self)
	neighbour.SetE(m_dotNeighbours.GetN())
	neighbour.SetS(m_dotNeighbours.GetW())


## Высота точки. От нее зависит цвет и скорость захвата
#onready var m_height: float = 0.0
## Цвет объекта. Зависит от высоты
#onready var m_color: Color = Color()
## Зона, частью которой является точка
#onready var m_area = null
## Сила точки для захвата другой точки
#onready var m_strength: float = 0.0
## Находится ли точка в стадии захвата
#onready var m_inCapture: bool = false
## Находится ли точка в состоянии спора
#onready var m_inContest: bool = false
