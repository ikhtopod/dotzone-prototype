extends Area2D


func _on_Timer_timeout():
	# Если текущий объект уничтожен пог таймеру, то значит, что он не пересекся
	# с нужныи объектом и надо очистить последний выделенный объект
	GameManager.ResetSelectedObject()
	queue_free()


func _on_FingerTouch_area_entered(area: Area2D):
	queue_free()
