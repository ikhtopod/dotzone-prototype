extends Node

const m_soundDotCreation = [ 
	preload("res://Audio/Sound/pop_00.wav"),
	preload("res://Audio/Sound/pop_01.wav"),
	preload("res://Audio/Sound/pop_02.wav"),
	preload("res://Audio/Sound/pop_03.wav") 
]

func GetRandomSoundDotCreation():
	return m_soundDotCreation[randi() % m_soundDotCreation.size()]
