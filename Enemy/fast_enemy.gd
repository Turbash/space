extends Enemy

@export var rotationRate:=20

func _process(delta: float) -> void:
	super._process(delta)
	rotate(deg_to_rad(rotationRate) * delta)
