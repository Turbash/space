extends Node

@onready var gameLabel:=$Label
@onready var gameTimer:=$GameTimer
@onready var startTimer:=$StartTimer

@export var gameTime:float=2
@export var startTime:float=1.2

func _ready() -> void:
	game_start()
	Signals.connect("on_game_over",_on_game_over)

func game_start():
	gameLabel.text="Here We Go!!!"
	startTimer.start(startTime)

func _on_game_over(player: Player):
	player.queue_free()
	gameLabel.visible=true
	gameLabel.text="Game Over!"
	gameTimer.start(gameTime)


func _on_start_timer_timeout() -> void:
	gameLabel.visible=false
	


func _on_game_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://HUD/start_screen.tscn")
