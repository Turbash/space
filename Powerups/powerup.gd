extends Area2D
class_name Powerup

@export var powerupMoveSpeed: float=50

func _physics_process(delta: float) -> void:
	position.y+=powerupMoveSpeed*delta


func _on_area_entered(area: Area2D) -> void:
	if area is Player:
		applyPowerup(area)
		queue_free()
		
func applyPowerup(player: Player):
	queue_free()


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
