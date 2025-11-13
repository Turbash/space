extends Control

@onready var score_label:=$ScoreLabel

func _ready() -> void:
	var score=Signals.score
	score_label.text="Great! Your scored: "+str(score)+" Points"

func _on_button_pressed() -> void:
	Signals.score=0
	get_tree().change_scene_to_file("res://MainScenes/game_play.tscn")
