extends Area2D

var plBullet = preload("res://Bullet/bullet.tscn")

@onready var animated_sprite=$AnimatedSprite
@onready var firing_positions=$FiringPositions
@onready var fire_delay_timer=$FireDelayTimer

@export var speed: float = 100
@export var fire_delay: float= 0.1
var vel:= Vector2(0,0)

func _process(delta: float) -> void:
	if vel.x<0:
		animated_sprite.play("left")
	elif vel.x>0:
		animated_sprite.play("right")
	else:
		animated_sprite.play("straight")
		
	if Input.is_action_pressed("shoot") and fire_delay_timer.is_stopped():
		fire_delay_timer.start(fire_delay)
		for child in firing_positions.get_children():
			
			var bullet:= plBullet.instantiate()
			bullet.global_position=child.global_position
			get_tree().current_scene.add_child(bullet)

func _physics_process(delta: float) -> void:
	var dirVec:=Vector2(0,0)
	
	if Input.is_action_pressed("move_left"):
		dirVec.x=-1
	elif Input.is_action_pressed("move_right"):
		dirVec.x=1
	if Input.is_action_pressed("move_up"):
		dirVec.y=-1
	elif Input.is_action_pressed("move_down"):
		dirVec.y=1
	
	vel=dirVec.normalized() * speed
	position+= vel*delta
	
	var viewRect:= get_viewport_rect()
	position.x=clamp(position.x,0,viewRect.size.x)
	position.y=clamp(position.y,0,viewRect.size.y)
	
