extends Node

"""В этом скрипте хранится информация о игровом процессе"""

# Индикатор захвата территории
# Список игроков


# Расстояние между точками
const DISTANCE_BETWEEN_POINTS: float = 72.0

### Tags ###
const PLAYER_TAG: String = "Player"
const ENEMY_TAG: String = "Enemy"


enum EGameplayPhase {
	UNKNOWN,
	MAIN_MENU,
	GENERATE,
	GAME,
	GAMEOFF,
}

var currenGameplayPhase = EGameplayPhase.UNKNOWN
