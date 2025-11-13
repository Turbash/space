extends Powerup

@export var shieldTimer: float=6.0

func applyPowerup(player: Player):
	player.applyShield(shieldTimer)
