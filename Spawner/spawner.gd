extends Node2D

const MIN_SPAWN_TIME=1.5

var preloadEnemies:=[
	preload("res://Enemy/bouncer_enemy.tscn"),
	preload("res://Enemy/fast_enemy.tscn"),
	preload('res://Enemy/slow_shooter.tscn')
]

var preloadPowerups:=[
	preload("res://Powerups/shield_powerup.tscn"),
	preload("res://Powerups/rapid_fire_powerup.tscn")
]

var plMeteor:=preload("res://Meteor/meteor.tscn")

@onready var spawnTimer:=$SpawnTimer
@onready var powerupSpawnTimer:=$PowerupSpawnTimer

@export var spawnTime: =5.0

@export var minPowerupSpawnTime:=3.0

@export var maxPowerupSpawnTime:=3

func _ready() -> void:
	randomize()
	spawnTimer.start(spawnTime)
	powerupSpawnTimer.start(minPowerupSpawnTime)

func getRandomSpawnPosition() -> Vector2:
	var viewRect:=get_viewport_rect()
	var xPos:=randf_range(viewRect.position.x,viewRect.end.x)
	return Vector2(xPos,position.y)

func _on_spawn_timer_timeout() -> void:
	if randf()<0.1:
		var meteor:=plMeteor.instantiate()
		meteor.position=getRandomSpawnPosition()
		get_tree().current_scene.add_child(meteor)
	else:
		var enemyPreload=preloadEnemies[randi()%preloadEnemies.size()]
		var enemy:Enemy=enemyPreload.instantiate()
		enemy.position=getRandomSpawnPosition()
		get_tree().current_scene.add_child(enemy)
	spawnTime-=0.1
	if spawnTime<MIN_SPAWN_TIME:
		spawnTime=MIN_SPAWN_TIME
	spawnTimer.start(spawnTime)


func _on_powerup_spawn_timer_timeout() -> void:
	var powerupPreload=preloadPowerups[randi()%preloadPowerups.size()]
	var powerup:Powerup=powerupPreload.instantiate()
	powerup.position=getRandomSpawnPosition()
	get_tree().current_scene.add_child(powerup)
	powerupSpawnTimer.start(randf_range(minPowerupSpawnTime,maxPowerupSpawnTime))
