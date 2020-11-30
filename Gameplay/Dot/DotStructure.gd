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
	const MAXCOORD: float = 5.0
	
	var m_queue: Array = []
	var m_dot: Dot = null
	
	func _init(root: Dot):
		if root:
			m_queue.push_back(root)
	
	func Generate() -> void:
		while !m_queue.empty():
			m_dot = m_queue.pop_front()
			if m_dot:
				CreateN()
				CreateNE()
				CreateE()
				CreateSE()
				CreateS()
				CreateSW()
				CreateW()
				CreateNW()
	
	# Заталкиваем в очередь переданную точку, если она соответствует условиям
	func PushToQueue(neighbour: Dot) -> void:
		var absPosition: Vector2 = neighbour.GetPosition().abs()
		if absPosition.x < MAXCOORD && absPosition.y < MAXCOORD:
			m_queue.push_back(neighbour)
	
	# Для каждой Create*() функции проверяем существует ли соседняя точка.
	# Если нет, то создаем ее, обновляем для нее соседей и заталкиваем в очередь.
	# Если существует, то просто обновляем соседей
	
	func CreateN() -> void:
		if !m_dot.GetDotNeighbours().GetN():
			var neighbour: Dot = Dot.new()
			neighbour.SetPosition(m_dot.GetPosition() + Vector2.UP)
			m_dot.GetDotNeighbours().SetN(neighbour)
			m_dot.UpdateNeighbourN()
			PushToQueue(neighbour)
		else:
			m_dot.UpdateNeighbourN()
	
	func CreateNE() -> void:
		if !m_dot.GetDotNeighbours().GetNE():
			var neighbour: Dot = Dot.new()
			neighbour.SetPosition(m_dot.GetPosition() + Vector2.UP + Vector2.RIGHT)
			m_dot.GetDotNeighbours().SetNE(neighbour)
			m_dot.UpdateNeighbourNE()
			PushToQueue(neighbour)
		else:
			m_dot.UpdateNeighbourNE()
	
	func CreateE() -> void:
		if !m_dot.GetDotNeighbours().GetE():
			var neighbour: Dot = Dot.new()
			neighbour.SetPosition(m_dot.GetPosition() + Vector2.RIGHT)
			m_dot.GetDotNeighbours().SetE(neighbour)
			m_dot.UpdateNeighbourE()
			PushToQueue(neighbour)
		else:
			m_dot.UpdateNeighbourE()
	
	func CreateSE() -> void:
		if !m_dot.GetDotNeighbours().GetSE():
			var neighbour: Dot = Dot.new()
			neighbour.SetPosition(m_dot.GetPosition() + Vector2.DOWN + Vector2.RIGHT)
			m_dot.GetDotNeighbours().SetSE(neighbour)
			m_dot.UpdateNeighbourSE()
			PushToQueue(neighbour)
		else:
			m_dot.UpdateNeighbourSE()
	
	func CreateS() -> void:
		if !m_dot.GetDotNeighbours().GetS():
			var neighbour: Dot = Dot.new()
			neighbour.SetPosition(m_dot.GetPosition() + Vector2.DOWN)
			m_dot.GetDotNeighbours().SetS(neighbour)
			m_dot.UpdateNeighbourS()
			PushToQueue(neighbour)
		else:
			m_dot.UpdateNeighbourS()
	
	func CreateSW() -> void:
		if !m_dot.GetDotNeighbours().GetSW():
			var neighbour: Dot = Dot.new()
			neighbour.SetPosition(m_dot.GetPosition() + Vector2.DOWN + Vector2.LEFT)
			m_dot.GetDotNeighbours().SetSW(neighbour)
			m_dot.UpdateNeighbourSW()
			PushToQueue(neighbour)
		else:
			m_dot.UpdateNeighbourSW()
	
	func CreateW() -> void:
		if !m_dot.GetDotNeighbours().GetW():
			var neighbour: Dot = Dot.new()
			neighbour.SetPosition(m_dot.GetPosition() + Vector2.LEFT)
			m_dot.GetDotNeighbours().SetW(neighbour)
			m_dot.UpdateNeighbourW()
			PushToQueue(neighbour)
		else:
			m_dot.UpdateNeighbourW()
	
	func CreateNW() -> void:
		if !m_dot.GetDotNeighbours().GetNW():
			var neighbour: Dot = Dot.new()
			neighbour.SetPosition(m_dot.GetPosition() + Vector2.UP + Vector2.LEFT)
			m_dot.GetDotNeighbours().SetNW(neighbour)
			m_dot.UpdateNeighbourNW()
			PushToQueue(neighbour)
		else:
			m_dot.UpdateNeighbourNW()



var m_root: Dot = null

func _init():
	m_root = Dot.new()
	NeighboursGenerator.new(m_root).Generate()
