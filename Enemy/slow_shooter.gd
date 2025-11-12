extends Enemy
class_name SlowShooter

@export var fireRate:= 1.0

@onready var fireTimer=$FireTimer

func _process(delta: float) -> void:
	if fireTimer.is_stopped():
		fire()
		fireTimer.start(fireRate)
