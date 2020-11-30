extends Area2D


func _on_Timer_timeout():
	queue_free()


func _on_FingerTouch_area_entered(area: Area2D):
	queue_free()
