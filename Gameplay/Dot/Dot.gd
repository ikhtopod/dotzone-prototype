extends Resource

#Класс, описывающий точку - ее текущее состояние, принадлежность и т.д.
class_name Dot


# Стороны света
enum ECardinalPoints {
	N,  # Север
	S,  # Юг
	W,  # Запад
	E,  # Восток
	NW, # Северо-запад
	NE, # Северо-Восток
	SW, # Юго-Запад
	SE, # Юго-Восток
}

# Противоположные стороны света
enum EOppositeCardinalPoints {
	N = ECardinalPoints.S,   # Север (становится Юг)
	S = ECardinalPoints.N,   # Юг (становится Север)
	W = ECardinalPoints.E,   # Запад (становится Восток)
	E = ECardinalPoints.W,   # Восток (становится Запад)
	NW = ECardinalPoints.SE, # Северо-запад (становится Юго-Восток)
	NE = ECardinalPoints.SW, # Северо-Восток (становится Юго-Запад)
	SW = ECardinalPoints.NE, # Юго-Запад (становится Северо-Восток)
	SE = ECardinalPoints.NW, # Юго-Восток (становится Северо-Запад)
}


# Класс для описания соседей
class DotNeighbours extends Resource:
	# Список соседних точек
	var m_neighbours: Array = \
		[ null, null, null, null, 
		  null, null, null, null ] setget ,GetNeighbours

	func GetNeighbours() -> Array:
		return m_neighbours.duplicate(false)

	# Вставить новую точку в массив, если есть свободные места (т.е. не null ячейка)
	# Если место нашлось, то возвращается true, иначе - false
	func InsertNeighbour(neighbour: Dot) -> bool:
		for i in range(m_neighbours.size()):
			if !m_neighbours[i]:
				m_neighbours[i] = neighbour
				return true
		
		return false
	
	# У текущей точки не становится соседних точек
	func Reset() -> void:
		for i in range(m_neighbours.size()):
			m_neighbours[i] = null
	
	# Оповестить соседей, что будет внесена новая точка, 
	# которую они должны считать соседней
	func NotifyNeighborsAboutChanges() -> void:
		for i in range(m_neighbours.size()):
			pass
	
	
	### North ###

	# Получить соседний объект по направлению к N
	func N() -> Dot:
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
	func S() -> Dot:
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
	func W() -> Dot:
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
	func E() -> Dot:
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
	func NW() -> Dot:
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
	func NE() -> Dot:
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
	func SW() -> Dot:
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
	func SE() -> Dot:
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


var m_neighbours: DotNeighbours = null setget ,GetNeighbours

func _init():
	m_neighbours = DotNeighbours.new()

func GetNeighbours() -> DotNeighbours:
		return m_neighbours














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
