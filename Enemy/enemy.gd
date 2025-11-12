extends Area2D
class_name Enemy

@export var verticalSpeed:float = 10
@export var health: int = 5

@onready var firingPositions:= $FiringPositions

var playerInArea: Player = null
var plButtet:= preload("res://Bullet/enemy_bullet.tscn")

func _process(delta: float) -> void:
	if playerInArea!=null:
		playerInArea.damage(1)

func _physics_process(delta: float) -> void:
	position.y+=verticalSpeed*delta

func damage(amount: int):
	health-=amount
	if health<=0:
		queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
	
func _on_area_entered(area: Area2D) -> void:
	if area is Player:
		playerInArea=area
		

func _on_area_exited(area: Area2D) -> void:
	if area is Player:
		playerInArea=null

func fire():
	for child in firingPositions.get_children():
		var bullet:=plButtet.instantiate()
		bullet.global_position=child.global_position
		get_tree().current_scene.add_child(bullet)
