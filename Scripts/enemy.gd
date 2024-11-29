extends CharacterBody2D

var future_positions = []
var current_position = 0
var idz = false
var is_sad = false


func _physics_process(delta):
	if idz:
		
		future_positions = Global.past_positions
		global_position = future_positions[0]
		future_positions.remove_at(0)
		current_position += 1
		%AnimationPlayer.play(Global.current_anim[0])
		Global.current_anim.remove_at(0)
		$Player.flip_h = Global.flip[0]
		Global.flip.remove_at(0)

func _on_timer_timeout() -> void:
	idz = true
