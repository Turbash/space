extends Powerup

@export var lifeIncrement: int=2

func applyPowerup(player: Player):
	player.incrementLife(lifeIncrement)
