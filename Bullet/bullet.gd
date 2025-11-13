extends Area2D

var plBulletEffect:=preload("res://Bullet/bullet_effect.tscn")

@export var speed:float= 500

func _physics_process(delta: float) -> void:
	position.y-=speed*delta


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("damageable"):
		var bullet_effect:=plBulletEffect.instantiate()
		bullet_effect.position=position
		get_parent().add_child(bullet_effect)
		
		var cam:=get_tree().current_scene.find_child("Camera2D",true,false)
		cam.shake(1) 
		
		area.damage(1)
		queue_free()
