extends Node2D


const DotScene: PackedScene = preload("res://Gameplay/Dot/Dot.tscn")

### Generator ###
var m_fieldCreator: FieldCreator = null

# Генерация объектов Dot
var m_timerGenerator: Timer = null
var c_InstantiateDots: GDScriptFunctionState = null
var c_Generate: GDScriptFunctionState = null
#################

var m_noise: OpenSimplexNoise = null


func _ready():
	GameManager.currenGameplayPhase = GameManager.EGameplayPhase.GENERATE
	
	InitNoise()
	InitFieldCreator()
	InitTimerGenerator()

func InitNoise() -> void:
	randomize()
	
	m_noise = OpenSimplexNoise.new()
	m_noise.seed = randi()
	m_noise.octaves = 1
	m_noise.period = 5.0
	m_noise.persistence = 0.4
	m_noise.lacunarity = 2.0


func InitFieldCreator() -> void:
	m_fieldCreator = FieldCreator.new()
	c_Generate = m_fieldCreator.GenerateCoroutine()
	c_InstantiateDots = InstantiateDots_Coroutine()


func InitTimerGenerator() -> void:
	m_timerGenerator = Timer.new()
	m_timerGenerator.process_mode = Timer.TIMER_PROCESS_IDLE
	m_timerGenerator.wait_time = 0.01
	m_timerGenerator.autostart = true
	m_timerGenerator.one_shot = false
	
	m_timerGenerator.connect("timeout", self, "SpawnDots")
	add_child(m_timerGenerator)
	m_timerGenerator.start()


func StopTimerGenerator() -> void:
	m_timerGenerator.disconnect("timeout", self, "SpawnDots")
	m_timerGenerator.stop()
	m_timerGenerator.queue_free()


# С увеличением количества объектов повышается и время их создания.
# Чем больше объектов, тем через дольшее время будет создан следующий.
func IncreaseTimerGeneratorTime() -> void:
	var countObjects: float = float(m_fieldCreator.GetField().size())
	var newWaitTime: float = 0.01 * (countObjects / 150.0)
	
	if newWaitTime > m_timerGenerator.wait_time:
		m_timerGenerator.wait_time = newWaitTime


func _exit_tree():
	if m_fieldCreator:
		m_fieldCreator.Clear()
	
	c_InstantiateDots = null
	c_Generate = null
	
	GameManager.Reset()


func SpawnDots() -> void:
	if GameManager.currenGameplayPhase == GameManager.EGameplayPhase.GENERATE:
		if c_Generate is GDScriptFunctionState and c_Generate.is_valid():
			c_Generate = c_Generate.resume()
			
			if c_InstantiateDots is GDScriptFunctionState and c_InstantiateDots.is_valid():
				c_InstantiateDots = c_InstantiateDots.resume()
				IncreaseTimerGeneratorTime()
		else:
			GameManager.currenGameplayPhase = GameManager.EGameplayPhase.GAME
			c_InstantiateDots = null
			c_Generate = null
			StopTimerGenerator()


# Создание объектов Dot на основе информации последнего сгенерированного
# объекта Point.
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
			var dotScene = DotScene.instance().Init(point, m_noise.get_noise_2dv(point.ToVector2()))
			dotScene.name = "Dot_%05d_%05d" % [blockNodeCounter, counter]
			GameManager.AssignMinMaxCoordinatesOfSides(dotScene.position)
			blockNode.add_child(dotScene)
			counter += 1
		
		yield()
