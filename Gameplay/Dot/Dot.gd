extends Node2D


const DefaultTextureResource = preload("res://Sprite/Dot/default.png")
const LinkedSelectedTextureResource = preload("res://Sprite/Dot/linked_selected.png")
const SelectionBorderTextureResource = preload("res://Sprite/Dot/selection_border.png")


var m_point: Point = Point.new()
var m_noise: float = 0.0 setget SetNoise, GetNoise
var m_strength: float = 1.0 setget ,GetStrength
var m_color: Color = Color.darkseagreen
var m_owner: Owner = null


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


func FingerTouchReaction() -> void:
	if HasOwner():
		if m_owner is OwnerPlayer:
			pass
		else:
			# pari
			m_owner = OwnerPlayer.new()
			$Sprite.texture = LinkedSelectedTextureResource
	else:
		m_owner = OwnerPlayer.new()
		$Sprite.texture = LinkedSelectedTextureResource
	
	GameManager.SetSelectedObject(self)


func _on_Area2D_area_entered(area: Area2D):
	if area.is_in_group(GameManager.FINGER_TOUCH_TAG):
		FingerTouchReaction()

# Функции, реализуемые объектом, который можно выделять
func Select() -> void:
	CreateSpriteSelection()

func Deselect() -> void:
	RemoveSpriteSelection()
#########################################################


func _on_AudioStreamPlayer2D_finished():
	$AudioStreamPlayer2D.queue_free()
