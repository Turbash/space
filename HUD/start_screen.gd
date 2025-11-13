extends Control



func _on_start_game_pressed() -> void:
	get_tree().change_scene_to_file("res://MainScenes/game_play.tscn")



func _on_instructions_pressed() -> void:
	get_tree().change_scene_to_file("res://HUD/instuctions.tscn")
