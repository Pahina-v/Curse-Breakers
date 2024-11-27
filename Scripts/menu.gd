extends Node2D


func _on_graj_pressed() -> void:
	get_tree().change_scene_to_file("res://Main.tscn")


func _on_menu_finished() -> void:
	$CanvasLayer/Menu.play()
