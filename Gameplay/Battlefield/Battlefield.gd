extends Node2D


const DotScene: PackedScene = preload("res://Gameplay/Dot/Dot.tscn")


var m_fieldCreator: FieldCreator = null

var c_InstantiateDots: GDScriptFunctionState = null
var c_Generate: GDScriptFunctionState = null


func _physics_process(delta):
	SpawnDots()


func _ready():
	GameManager.currenGameplayPhase = GameManager.EGameplayPhase.GENERATE
	
	m_fieldCreator = FieldCreator.new()
	c_Generate = m_fieldCreator.GenerateCoroutine()
	c_InstantiateDots = InstantiateDots_Coroutine()


func _exit_tree():
	if m_fieldCreator:
		m_fieldCreator.Clear()
	
	c_InstantiateDots = null
	c_Generate = null


func SpawnDots() -> void:
	if GameManager.currenGameplayPhase == GameManager.EGameplayPhase.GENERATE:
		if c_Generate is GDScriptFunctionState and c_Generate.is_valid():
			c_Generate = c_Generate.resume()
			
			if c_InstantiateDots is GDScriptFunctionState and c_InstantiateDots.is_valid():
				c_InstantiateDots = c_InstantiateDots.resume()
		else:
			GameManager.currenGameplayPhase = GameManager.EGameplayPhase.GAME
			c_InstantiateDots = null
			c_Generate = null


func InstantiateDots_Coroutine() -> void:
	var blockNodeCounter: int = 0
	var blockNode: Node2D = null
	var counter: int = 0
	
	while true:
		if counter > 25 or counter < 1:
			counter = 1
			blockNodeCounter += 1
			blockNode = Node2D.new()
			blockNode.name = "BlockDots%05d" % blockNodeCounter
			add_child(blockNode)
		
		var point: Point = m_fieldCreator.GetLastAddedPoint()
		if point:
			var dotScene = DotScene.instance().Init(point)
			dotScene.name = "Dot_%05d_%05d" % [blockNodeCounter, counter]
			blockNode.add_child(dotScene)
			counter += 1
		
		yield()
