extends Node2D


func _on_graj_pressed() -> void:
	get_tree().change_scene_to_file("res://Main.tscn")
func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed('cont_accept'):
		get_tree().change_scene_to_file("res://Main.tscn")

func _on_menu_finished() -> void:
	$CanvasLayer/Menu.play()
