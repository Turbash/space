extends Control

var plLifeIcon:=preload("res://HUD/life_icon.tscn")

@onready var life_container:=$LIfeContainer

func _ready() -> void:
	clear_lives()
	Signals.connect("on_player_life_changed", _on_player_life_changed)
	
func clear_lives():
	for child in life_container.get_children():
		child.queue_free()
		
func set_lives(lives: int):
	clear_lives()
	for i in range(lives):
		life_container.add_child(plLifeIcon.instantiate())

func _on_player_life_changed(life: int):
	set_lives(life)
