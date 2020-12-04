extends Node2D


const DotScene: PackedScene = preload("res://Gameplay/Dot/Dot.tscn")


var m_fieldCreator: FieldCreator = null

func _enter_tree():
	m_fieldCreator = FieldCreator.new()
	m_fieldCreator.Generate()
	InstantiateDots()


func _exit_tree():
	if m_fieldCreator:
		m_fieldCreator.Clear()
	
	for child in get_children():
		if child:
			child.queue_free()
	
	queue_free()


func InstantiateDots() -> void:
	var blockNodeCounter: int = 0
	var blockNode: Node2D = null
	var counter: int = 0
	
	for point in m_fieldCreator.GetField():
		if counter > 25 or counter < 1:
			counter = 1
			blockNodeCounter += 1
			blockNode = Node2D.new()
			blockNode.name = "BlockDots%05d" % blockNodeCounter
			add_child(blockNode)
			
		var dotScene = DotScene.instance().Init(point)
		dotScene.name = "Dot%05d" % counter
		blockNode.add_child(dotScene)
		counter += 1
