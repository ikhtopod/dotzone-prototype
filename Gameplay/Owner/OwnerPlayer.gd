extends Owner

class_name OwnerPlayer


func _init(name: String = "") -> void:
	.SetName(name if (name and not !name.empty()) else GameManager.PLAYER_TAG)
