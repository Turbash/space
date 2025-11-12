extends Node2D

const MIN_SPAWN_TIME=1.5

var preloadEnemies:=[
	preload("res://Enemy/bouncer_enemy.tscn"),
	preload("res://Enemy/fast_enemy.tscn"),
	preload('res://Enemy/slow_shooter.tscn')
]

var plMeteor:=preload("res://Meteor/meteor.tscn")

@onready var spawnTimer:=$SpawnTimer

var spawnTime: =5.0

func _ready() -> void:
	randomize()
	spawnTimer.start(spawnTime)



func _on_spawn_timer_timeout() -> void:
	var viewRect:=get_viewport_rect()
	var xPos:=randf_range(viewRect.position.x,viewRect.end.x)
	
	if randf()<0.1:
		var meteor:=plMeteor.instantiate()
		meteor.position=Vector2(xPos,position.y)
		get_tree().current_scene.add_child(meteor)
	else:
		var enemyPreload=preloadEnemies[randi()%preloadEnemies.size()]
		var enemy:Enemy=enemyPreload.instantiate()
		enemy.position=Vector2(xPos,position.y)
		get_tree().current_scene.add_child(enemy)
	spawnTime-=0.1
	if spawnTime<MIN_SPAWN_TIME:
		spawnTime=MIN_SPAWN_TIME
	spawnTimer.start(spawnTime)
