extends Control

var plLifeIcon:=preload("res://HUD/life_icon.tscn")

@onready var scoreLabel=$Score

var score:int=0 

@onready var life_container:=$LIfeContainer

func _ready() -> void:
	clear_lives()
	Signals.connect("on_player_life_changed", _on_player_life_changed)
	Signals.connect("on_score_increment", _on_score_increment)
func clear_lives():
	for child in life_container.get_children():
		child.queue_free()
		
func set_lives(lives: int):
	clear_lives()
	for i in range(lives):
		life_container.add_child(plLifeIcon.instantiate())

func _on_player_life_changed(life: int):
	set_lives(life)
	
func _on_score_increment(amount: int):
	score+=amount
	scoreLabel.text=str(score)
	Signals.score+=amount
