extends Area2D
class_name Player

var plBullet = preload("res://Bullet/bullet.tscn")

@onready var animated_sprite=$AnimatedSprite
@onready var firing_positions=$FiringPositions
@onready var fire_delay_timer=$FireDelayTimer
@onready var invincibility_timer=$InvincibilityTimer
@onready var shield_sprite=$Sprite2D
@onready var rapid_fire_timer=$RapidFireTimer

@export var speed: float = 100
@export var normal_fire_delay: float= 0.12
@export var rapid_fire_delay: float=0.08
@export var life:int=3
@export var invincibility_time=1.5
@export var max_life: int = 5

var vel:= Vector2(0,0)
var fire_delay: float=normal_fire_delay
var dragging := false
var drag_offset := Vector2.ZERO
var touch_id:= -1

func _ready() -> void:
	shield_sprite.visible=false
	Signals.emit_signal("on_player_life_changed", life)

func _input(event: InputEvent) -> void:
	if event is InputEventScreenTouch and event.pressed:
		dragging = true
		drag_offset = global_position - event.position

	elif event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		dragging = true
		drag_offset = global_position - event.position

	elif event is InputEventScreenTouch and not event.pressed:
		dragging = false
	elif event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
		dragging = false

func _process(delta: float) -> void:
	if vel.x<0:
		animated_sprite.play("left")
	elif vel.x>0:
		animated_sprite.play("right")
	else:
		animated_sprite.play("straight")
	if dragging:
		global_position = get_viewport().get_mouse_position() + drag_offset
	if fire_delay_timer.is_stopped():
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
	Signals.emit_signal("on_player_life_changed", life)
	
	var cam:=get_tree().current_scene.find_child("Camera2D",true,false)
	cam.shake(20) 
	
	if life<=0:
		print("Player Died!")
		Signals.emit_signal("on_game_over",self)

func incrementLife(amount: int):
	if life<max_life:
		life+=amount
		Signals.emit_signal("on_player_life_changed",life)

func _on_invincibility_timer_timeout() -> void:
	shield_sprite.visible=false
	
func applyRapidFire(time: float):
	fire_delay=rapid_fire_delay
	rapid_fire_timer.start(time + rapid_fire_timer.time_left)
	
func applyShield(time: float):
	invincibility_timer.start(time + invincibility_timer.time_left)
	shield_sprite.visible=true


func _on_rapid_fire_timer_timeout() -> void:
	fire_delay=normal_fire_delay
	
