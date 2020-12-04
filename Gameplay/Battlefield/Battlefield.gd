extends Node2D


const DotScene: PackedScene = preload("res://Gameplay/Dot/Dot.tscn")


var m_fieldCreator: FieldCreator = null

var c_InstantiateDots_coroutine = null


func _process(delta):
	if c_InstantiateDots_coroutine:
		c_InstantiateDots_coroutine = c_InstantiateDots_coroutine.resume()


func _enter_tree():
	m_fieldCreator = FieldCreator.new()
	m_fieldCreator.Generate()
	c_InstantiateDots_coroutine = InstantiateDots()


func _exit_tree():
	if m_fieldCreator:
		m_fieldCreator.Clear()


func InstantiateDots() -> void:
	var blockNodeCounter: int = 0
	var blockNode: Node2D = null
	var counter: int = 0
	
	for key in m_fieldCreator.GetField().keys():
		if counter > 25 or counter < 1:
			counter = 1
			blockNodeCounter += 1
			blockNode = Node2D.new()
			blockNode.name = "BlockDots%05d" % blockNodeCounter
			add_child(blockNode)
		
		var point: Point = m_fieldCreator.GetField()[key]
		var dotScene = DotScene.instance().Init(point)
		dotScene.name = "Dot_%05d_%05d" % [blockNodeCounter, counter]
		blockNode.add_child(dotScene)
		counter += 1
		yield()
