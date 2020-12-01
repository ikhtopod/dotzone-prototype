extends Resource

class_name DotStructure


# Класс, описывающий точку - ее текущее состояние, принадлежность и т.д.
# Шаблон MVC:
#     Model: DotStructure
#     View: DotView
#     Controller:
#         View to Model: DotView->ToucnManager->DotStructure
#         Model to View: DotStructure->DotView


# Класс для создания соседних точек
class NeighboursGenerator extends Resource:
	const MAXCOORD: float = 20.0
	
	var m_queue: Array = []
	var m_neighbour: Dot = null
	
	func _init(root: Dot):
		if root:
			m_queue.push_back(root)
	
	func Generate() -> void:
		while !m_queue.empty():
			if m_queue.front():
				CreateN()
				CreateNE()
				CreateE()
				CreateSE()
				CreateS()
				CreateSW()
				CreateW()
				CreateNW()
			
			m_queue.pop_front()
	
	# Заталкиваем в очередь переданную точку, если она соответствует условиям
	func PushToQueue() -> bool:
		var absPosition: Vector2 = m_neighbour.GetPosition().abs()
		if absPosition.x < MAXCOORD && absPosition.y < MAXCOORD:
			m_queue.push_back(m_neighbour)
			return true
		return false
	
	# Для каждой Create*() функции проверяем существует ли соседняя точка.
	# Если нет, то создаем ее, обновляем для нее соседей и заталкиваем в очередь.
	# Если существует, то просто обновляем соседей
	
	func CreateN() -> void:
		if m_queue.front().GetDotNeighbours().GetN():
			m_queue.front().UpdateNeighbourN()
		else:
			m_neighbour = Dot.new()
			m_neighbour.SetPosition(m_queue.front().GetPosition() + Vector2.UP)
			if not PushToQueue():
				m_neighbour = null
				return
			m_queue.front().GetDotNeighbours().SetN(m_queue.back())
			m_queue.back().GetDotNeighbours().SetOppositeN(m_queue.front())
			m_queue.front().UpdateNeighbourN()
			
	
	func CreateNE() -> void:
		if m_queue.front().GetDotNeighbours().GetNE():
			m_queue.front().UpdateNeighbourNE()
		else:
			m_neighbour = Dot.new()
			m_neighbour.SetPosition(m_queue.front().GetPosition() + Vector2.UP + Vector2.RIGHT)
			if not PushToQueue():
				m_neighbour = null
				return
			m_queue.front().GetDotNeighbours().SetNE(m_queue.back())
			m_queue.back().GetDotNeighbours().SetOppositeNE(m_queue.front())
			m_queue.front().UpdateNeighbourNE()
	
	func CreateE() -> void:
		if m_queue.front().GetDotNeighbours().GetE():
			m_queue.front().UpdateNeighbourE()
		else:
			m_neighbour = Dot.new()
			m_neighbour.SetPosition(m_queue.front().GetPosition() + Vector2.RIGHT)
			if not PushToQueue():
				m_neighbour = null
				return
			m_queue.front().GetDotNeighbours().SetE(m_queue.back())
			m_queue.back().GetDotNeighbours().SetOppositeE(m_queue.front())
			m_queue.front().UpdateNeighbourE()
	
	func CreateSE() -> void:
		if m_queue.front().GetDotNeighbours().GetSE():
			m_queue.front().UpdateNeighbourSE()
		else:
			m_neighbour = Dot.new()
			m_neighbour.SetPosition(m_queue.front().GetPosition() + Vector2.DOWN + Vector2.RIGHT)
			if not PushToQueue():
				m_neighbour = null
				return
			m_queue.front().GetDotNeighbours().SetSE(m_queue.back())
			m_queue.back().GetDotNeighbours().SetOppositeSE(m_queue.front())
			m_queue.front().UpdateNeighbourSE()
	
	func CreateS() -> void:
		if m_queue.front().GetDotNeighbours().GetS():
			m_queue.front().UpdateNeighbourS()
		else:
			m_neighbour = Dot.new()
			m_neighbour.SetPosition(m_queue.front().GetPosition() + Vector2.DOWN)
			if not PushToQueue():
				m_neighbour = null
				return
			m_queue.front().GetDotNeighbours().SetS(m_queue.back())
			m_queue.back().GetDotNeighbours().SetOppositeS(m_queue.front())
			m_queue.front().UpdateNeighbourS()
	
	func CreateSW() -> void:
		if m_queue.front().GetDotNeighbours().GetSW():
			m_queue.front().UpdateNeighbourSW()
		else:
			m_neighbour = Dot.new()
			m_neighbour.SetPosition(m_queue.front().GetPosition() + Vector2.DOWN + Vector2.LEFT)
			if not PushToQueue():
				m_neighbour = null
				return
			m_queue.front().GetDotNeighbours().SetSW(m_queue.back())
			m_queue.back().GetDotNeighbours().SetOppositeSW(m_queue.front())
			m_queue.front().UpdateNeighbourSW()
	
	func CreateW() -> void:
		if m_queue.front().GetDotNeighbours().GetW():
			m_queue.front().UpdateNeighbourW()
		else:
			m_neighbour = Dot.new()
			m_neighbour.SetPosition(m_queue.front().GetPosition() + Vector2.LEFT)
			if not PushToQueue():
				m_neighbour = null
				return
			m_queue.front().GetDotNeighbours().SetW(m_queue.back())
			m_queue.back().GetDotNeighbours().SetOppositeW(m_queue.front())
			m_queue.front().UpdateNeighbourW()
	
	func CreateNW() -> void:
		if m_queue.front().GetDotNeighbours().GetNW():
			m_queue.front().UpdateNeighbourNW()
		else:
			m_neighbour = Dot.new()
			m_neighbour.SetPosition(m_queue.front().GetPosition() + Vector2.UP + Vector2.LEFT)
			if not PushToQueue():
				m_neighbour = null
				return
			m_queue.front().GetDotNeighbours().SetNW(m_queue.back())
			m_queue.back().GetDotNeighbours().SetOppositeNW(m_queue.front())
			m_queue.front().UpdateNeighbourNW()


var m_root: Dot = null

func _init():
	m_root = Dot.new()
	NeighboursGenerator.new(m_root).Generate()


func Clear() -> void:
	if !m_root:
		return
	
	var queue: Array = [m_root]
	
	while (!queue.empty()):
		var dot: Dot = queue.pop_front()
		if !dot:
			continue
		
		var neighbours: Array = dot.GetDotNeighbours().GetNeighbours()
		for i in range(neighbours.size()):
			if neighbours[i]:
				queue.push_back(neighbours[i])
		
		if dot:
			dot.Clear()
