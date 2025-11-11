extends Area2D
class_name Player

var plBullet = preload("res://Bullet/bullet.tscn")

@onready var animated_sprite=$AnimatedSprite
@onready var firing_positions=$FiringPositions
@onready var fire_delay_timer=$FireDelayTimer
@onready var invincibility_timer=$InvincibilityTimer
@onready var shield_sprite=$Sprite2D

@export var speed: float = 100
@export var fire_delay: float= 0.1
@export var life:int=3
@export var invincibility_time=1.5
var vel:= Vector2(0,0)

func _ready() -> void:
	shield_sprite.visible=false

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
	
func damage(amount:int):
	if(not invincibility_timer.is_stopped()):
		return
	invincibility_timer.start(invincibility_time)
	shield_sprite.visible=true
	life-=amount
	print("Player life=%s" %life)
	if life<=0:
		print("Player Died!")
		queue_free()


func _on_invincibility_timer_timeout() -> void:
	shield_sprite.visible=false
