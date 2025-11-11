extends Area2D

@export var minSpeed: float = 10
@export var maxSpeed: float= 20
@export var maxRotationRate: float=20
@export var minRotationRate: float=-20

@export var life:int =20

var speed: float=0
var rotationRate: float=0
var playerInArea: Player=null

func _ready() -> void:
	speed=randf_range(minSpeed,maxSpeed)
	rotationRate=randf_range(minRotationRate,maxRotationRate)
	
func _process(delta: float) -> void:
	if playerInArea:
		playerInArea.damage(1)
	
	
func _physics_process(delta: float) -> void:
	rotation_degrees+=rotationRate*delta
	position.y+=speed*delta


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
	
func damage(amount: int):
	life-=amount
	if life<=0:
		queue_free()


func _on_area_entered(area: Area2D) -> void:
	if area is Player:
		playerInArea=area


func _on_area_exited(area: Area2D) -> void:
	if area is Player:
		playerInArea=null
