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
		#return m_neighbours
	
	func Clear() -> void:
		m_neighbours.clear()
	
	### North ###

	# Получить соседний объект по направлению к N
	func GetN() -> Dot:
		return m_neighbours[ECardinalPoints.N]

	# Изменить соседний объект по направлению к N
	func SetN(neighbour: Dot) -> void:
		m_neighbours[ECardinalPoints.N] = neighbour

	# Получить соседний объект по направлению противоположному относительно N
	func GetOppositeN() -> Dot:
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
	func GetOppositeS() -> Dot:
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
	func GetOppositeW() -> Dot:
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
	func GetOppositeE() -> Dot:
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
	func GetOppositeNW() -> Dot:
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
	func GetOppositeNE() -> Dot:
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
	func GetOppositeSW() -> Dot:
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
	func GetOppositeSE() -> Dot:
		return m_neighbours[EOppositeCardinalPoints.SE]

	# Изменить соседний объект по направлению противоположному относительно SE
	func SetOppositeSE(neighbour: Dot) -> void:
		m_neighbours[EOppositeCardinalPoints.SE] = neighbour
### End DotNeighbours ###


var m_dotNeighbours: DotNeighbours = null setget ,GetDotNeighbours
var m_position: Vector2 = Vector2() setget SetPosition, GetPosition


func _init(position: Vector2 = Vector2()):
	m_dotNeighbours = DotNeighbours.new()
	m_position = position


func GetDotNeighbours() -> DotNeighbours:
		return m_dotNeighbours


func GetPosition() -> Vector2:
	return m_position

func SetPosition(position: Vector2) -> void:
	m_position = position


func Clear() -> void:
	m_dotNeighbours.Clear()


### UpdateNeighbours ###

# Обновить соседние точки на N, общие как для точки на N так и для текущей точки.
# Аналогично для всех функций UpdateNeighbour*()

func UpdateNeighbourN() -> void:
	var neighbour = m_dotNeighbours.GetN().GetDotNeighbours()
	
	if !neighbour.GetW() && m_dotNeighbours.GetNW():
		neighbour.SetW(m_dotNeighbours.GetNW())
		neighbour.GetW().GetDotNeighbours().SetOppositeW(m_dotNeighbours.GetN())
		
	if !neighbour.GetE() && m_dotNeighbours.GetNE():
		neighbour.SetE(m_dotNeighbours.GetNE())
		neighbour.GetE().GetDotNeighbours().SetOppositeE(m_dotNeighbours.GetN())
	
	if !neighbour.GetSW() && m_dotNeighbours.GetW():
		neighbour.SetSW(m_dotNeighbours.GetW())
		neighbour.GetSW().GetDotNeighbours().SetOppositeSW(m_dotNeighbours.GetN())
	
	if !neighbour.GetSE() && m_dotNeighbours.GetE():
		neighbour.SetSE(m_dotNeighbours.GetE())
		neighbour.GetSE().GetDotNeighbours().SetOppositeSE(m_dotNeighbours.GetN())


func UpdateNeighbourNE() -> void:
	var neighbour = m_dotNeighbours.GetNE().GetDotNeighbours()
	
	if !neighbour.GetW() && m_dotNeighbours.GetN():
		neighbour.SetW(m_dotNeighbours.GetN())
		neighbour.GetW().GetDotNeighbours().SetOppositeW(m_dotNeighbours.GetNE())
	
	if !neighbour.GetS() && m_dotNeighbours.GetE():
		neighbour.SetS(m_dotNeighbours.GetE())
		neighbour.GetS().GetDotNeighbours().SetOppositeS(m_dotNeighbours.GetNE())


func UpdateNeighbourE() -> void:
	var neighbour = m_dotNeighbours.GetE().GetDotNeighbours()
	
	if !neighbour.GetN() && m_dotNeighbours.GetNE():
		neighbour.SetN(m_dotNeighbours.GetNE())
		neighbour.GetN().GetDotNeighbours().SetOppositeN(m_dotNeighbours.GetE())
	
	if !neighbour.GetS() && m_dotNeighbours.GetSE():
		neighbour.SetS(m_dotNeighbours.GetSE())
		neighbour.GetS().GetDotNeighbours().SetOppositeS(m_dotNeighbours.GetE())
	
	if !neighbour.GetNW() && m_dotNeighbours.GetN():
		neighbour.SetNW(m_dotNeighbours.GetN())
		neighbour.GetNW().GetDotNeighbours().SetOppositeNW(m_dotNeighbours.GetE())
	
	if !neighbour.GetSW() && m_dotNeighbours.GetS():
		neighbour.SetSW(m_dotNeighbours.GetS())
		neighbour.GetSW().GetDotNeighbours().SetOppositeSW(m_dotNeighbours.GetE())


func UpdateNeighbourSE() -> void:
	var neighbour = m_dotNeighbours.GetSE().GetDotNeighbours()
	
	if !neighbour.GetN() && m_dotNeighbours.GetE():
		neighbour.SetN(m_dotNeighbours.GetE())
		neighbour.GetN().GetDotNeighbours().SetOppositeN(m_dotNeighbours.GetSE())
	
	if !neighbour.GetW() && m_dotNeighbours.GetS():
		neighbour.SetW(m_dotNeighbours.GetS())
		neighbour.GetW().GetDotNeighbours().SetOppositeW(m_dotNeighbours.GetSE())


func UpdateNeighbourS() -> void:
	var neighbour = m_dotNeighbours.GetS().GetDotNeighbours()
	
	if !neighbour.GetW() && m_dotNeighbours.GetSW():
		neighbour.SetW(m_dotNeighbours.GetSW())
		neighbour.GetW().GetDotNeighbours().SetOppositeW(m_dotNeighbours.GetS())
	
	if !neighbour.GetE() && m_dotNeighbours.GetSE():
		neighbour.SetE(m_dotNeighbours.GetSE())
		neighbour.GetE().GetDotNeighbours().SetOppositeE(m_dotNeighbours.GetS())
	
	if !neighbour.GetNW() && m_dotNeighbours.GetW():
		neighbour.SetNW(m_dotNeighbours.GetW())
		neighbour.GetNW().GetDotNeighbours().SetOppositeNW(m_dotNeighbours.GetS())
	
	if !neighbour.GetNE() && m_dotNeighbours.GetE():
		neighbour.SetNE(m_dotNeighbours.GetE())
		neighbour.GetNE().GetDotNeighbours().SetOppositeNE(m_dotNeighbours.GetS())


func UpdateNeighbourSW() -> void:
	var neighbour = m_dotNeighbours.GetSW().GetDotNeighbours()
	
	if !neighbour.GetN() && m_dotNeighbours.GetW():
		neighbour.SetN(m_dotNeighbours.GetW())
		neighbour.GetN().GetDotNeighbours().SetOppositeN(m_dotNeighbours.GetSW())
	
	if !neighbour.GetE() && m_dotNeighbours.GetS():
		neighbour.SetE(m_dotNeighbours.GetS())
		neighbour.GetE().GetDotNeighbours().SetOppositeE(m_dotNeighbours.GetSW())


func UpdateNeighbourW() -> void:
	var neighbour = m_dotNeighbours.GetW().GetDotNeighbours()
	
	if !neighbour.GetN() && m_dotNeighbours.GetNW():
		neighbour.SetN(m_dotNeighbours.GetNW())
		neighbour.GetN().GetDotNeighbours().SetOppositeN(m_dotNeighbours.GetW())
	
	if !neighbour.GetS() && m_dotNeighbours.GetSW():
		neighbour.SetS(m_dotNeighbours.GetSW())
		neighbour.GetS().GetDotNeighbours().SetOppositeS(m_dotNeighbours.GetW())
	
	if !neighbour.GetNE() && m_dotNeighbours.GetN():
		neighbour.SetNE(m_dotNeighbours.GetN())
		neighbour.GetNE().GetDotNeighbours().SetOppositeNE(m_dotNeighbours.GetW())
	
	if !neighbour.GetSE() && m_dotNeighbours.GetS():
		neighbour.SetSE(m_dotNeighbours.GetS())
		neighbour.GetSE().GetDotNeighbours().SetOppositeSE(m_dotNeighbours.GetW())
	

func UpdateNeighbourNW() -> void:
	var neighbour = m_dotNeighbours.GetNW().GetDotNeighbours()
	
	if !neighbour.GetE() && m_dotNeighbours.GetN():
		neighbour.SetE(m_dotNeighbours.GetN())
		neighbour.GetE().GetDotNeighbours().SetOppositeE(m_dotNeighbours.GetNW())
	
	if !neighbour.GetS() && m_dotNeighbours.GetW():
		neighbour.SetS(m_dotNeighbours.GetW())
		neighbour.GetS().GetDotNeighbours().SetOppositeS(m_dotNeighbours.GetNW())


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
