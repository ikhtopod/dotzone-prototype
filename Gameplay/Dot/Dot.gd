extends Node2D


const DefaultTextureResource = preload("res://Sprite/Dot/default.png")
const SelectedTextureResource = preload("res://Sprite/Dot/selected.png")
const LinkedTextureResource = preload("res://Sprite/Dot/linked.png")
const LinkedSelectedTextureResource = preload("res://Sprite/Dot/linked_selected.png")

var m_point: Point = Point.new()
var m_noise: float = 0.0 setget SetNoise, GetNoise
var m_strength: float = 1.0 setget ,GetStrength
var m_color: Color = Color.darkseagreen
var m_owner: Owner = null


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


func _on_Area2D_area_entered(area: Area2D):
	if area.is_in_group(GameManager.FINGER_TOUCH_TAG):
		GameManager.SetSelectedObject(self)

# Функции, реализуемые объектом, который можно выделять #
func Select() -> void:
	$Sprite.texture = SelectedTextureResource

func Deselect() -> void:
	$Sprite.texture = DefaultTextureResource
#########################################################
