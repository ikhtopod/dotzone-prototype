extends Reference


class LinkedListItem extends Reference:
	var m_next = null
	var m_prev = null
	var m_data = {}
	
	func _init(data):
		m_data = data
	
	func Link(other: LinkedListItem) -> void:
		other.m_prev = self
		m_next = other
	
	func Unlink() -> void:
		var next = m_next
		var prev = m_prev
		
		if prev:
			prev.m_next = m_next
		
		if next:
			next.m_prev = m_prev


var m_tail: LinkedListItem = null   setget ,back
var m_head: LinkedListItem = m_tail setget ,front
var m_size: int = 0 setget ,size


func front():
	return m_head.m_data


func back():
	return m_tail.m_data


func size() -> int:
	return m_size

func __SizeIncrement() -> void:
	m_size += 1
	
	if m_size < 1:
		m_size = 1

func __SizeDecrement() -> void:
	m_size -= 1
	
	if m_size < 0:
		m_size = 0


func empty() -> bool:
	return size() == 0


func push_back(data) -> void:
	if empty():
		m_head = LinkedListItem.new(data)
		m_tail = m_head
	else:
		var newTail = LinkedListItem.new(data)
		newTail.Link(m_tail)
		m_tail = newTail
	
	__SizeIncrement()


func push_front(data) -> void:
	if empty():
		m_head = LinkedListItem.new(data)
		m_tail = m_head
	else:
		var newHead = LinkedListItem.new(data)
		m_head.Link(newHead)
		m_head = newHead
	
	__SizeIncrement()


func pop_back() -> void:
	if empty():
		return
	
	m_tail = m_tail.m_next
	__SizeDecrement()


func pop_front() -> void:
	if empty():
		return
	
	m_head = m_head.m_prev
	__SizeDecrement()

func clear() -> void:
	while size():
		pop_front()
