extends Node2D


class_name Dot


const DefaultTextureResource = preload("res://Sprite/Dot/default.png")
const LinkedTextureResource = preload("res://Sprite/Dot/linked.png")
const SelectionBorderTextureResource = preload("res://Sprite/Dot/selection_border.png")
const NeighbourFinderScene = preload("res://Gameplay/Dot/NeighbourFinder.tscn")
const DotLineScene = preload("res://Gameplay/Dot/DotLine.tscn")

var m_point: Point = Point.new()
var m_noise: float = 0.0 setget SetNoise, GetNoise
var m_strength: float = 1.0 setget ,GetStrength
var m_color: Color = Color.darkseagreen
var m_owner: Owner = null setget ,GetOwner

var m_neighbours: Array = []


func _enter_tree():
	$AudioStreamPlayer2D.stream = AudioManager.GetRandomSoundDotCreation()


func Init(point: Point, noise: float):
	m_point = Point.new().InitPoint(point)
	position = m_point.ToVector2() * GameManager.DISTANCE_BETWEEN_POINTS
	SetNoise(noise)
	return self


func GetStrength() -> float:
	return m_strength

func GetNoise() -> float:
	return m_noise

func SetNoise(noise: float) -> void:
	m_noise = noise
	SetStrengthByNoise()
	SetColorByNoise()

func SetStrengthByNoise() -> void:
	m_strength = m_noise

func SetColorByNoise() -> void:
	if GetNoise() > 0.0:
		m_color = Color.darkseagreen.linear_interpolate(Color.darkred, GetNoise())
	else:
		m_color = Color.darkseagreen.linear_interpolate(Color.dodgerblue, abs(GetNoise()))
	
	$Sprite.self_modulate = m_color


func HasOwner() -> bool:
	return m_owner != null

func GetOwner() -> Owner:
	return m_owner


func CreateSpriteSelection() -> void:
	if has_node("SpriteSelection"):
		return
	
	var spriteSelection: Sprite = Sprite.new()
	spriteSelection.name = "SpriteSelection"
	spriteSelection.texture = SelectionBorderTextureResource
	add_child(spriteSelection)

func RemoveSpriteSelection() -> void:
	if has_node("SpriteSelection"):
		get_node("SpriteSelection").queue_free()


func CreateNeighbourFinder():
	m_neighbours.clear()
	
	var nf = NeighbourFinderScene.instance()
	nf.connect("area_entered", self, "_on_NeighbourFinder_area_entered")
	nf.connect("tree_exited", self, "_on_NeighbourFinder_tree_exited")
	call_deferred("add_child", nf)

# Вызывается, когда NeighbourFinderScene пересекся с объектом
func _on_NeighbourFinder_area_entered(area):
	if area == $Area2D:
		return
	
	m_neighbours.push_back(area.get_parent())

# Вызывается, когда NeighbourFinderScene уничтожается, чтобы можно было 
# воспользоваться результатом работы _on_NeighbourFinder_area_entered
func _on_NeighbourFinder_tree_exited():
	DrawLines()

func DrawLines() -> void:
	for child in $Lines.get_children():
		child.queue_free()
	
	for neighbour in m_neighbours:
		if neighbour.GetOwner() and neighbour.GetOwner() is OwnerPlayer:
			var line = DotLineScene.instance()
			line.SetEndPointPosition(neighbour.position - self.position)
			$Lines.add_child(line)


func FingerTouchReaction() -> void:
	if HasOwner():
		if m_owner is OwnerPlayer:
			pass
		else:
			# pari
			m_owner = OwnerPlayer.new()
			$Sprite.texture = LinkedTextureResource
	else:
		m_owner = OwnerPlayer.new()
		$Sprite.texture = LinkedTextureResource
	
	GameManager.SetSelectedObject(self)


func _on_Area2D_area_entered(area: Area2D):
	if area.is_in_group(GameManager.FINGER_TOUCH_TAG):
		FingerTouchReaction()

# Функции, реализуемые объектом, который можно выделять
func Select() -> void:
	CreateNeighbourFinder()
	CreateSpriteSelection()

func Deselect() -> void:
	RemoveSpriteSelection()
#########################################################


func _on_AudioStreamPlayer2D_finished():
	$AudioStreamPlayer2D.queue_free()
