extends Node2D

@export var move:int = 1:
	set(value):
		move = value
		
@export_range(1, 25) var length:int = 1:
	set(value):
		length = value
		set_length()
		

@export_range(1, 4) var direction:int=1:
	set(value):
		direction = value
		
@export var moving: bool:
	set(value):
		moving = value
			
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_length()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if moving:
		if $'AnimationPlayer'.current_animation_position == 0:
			action()
		if $'AnimationPlayer'.current_animation_position == move:
			reverse_action()
		
		
	
func set_length():
	if length == 1:
		$TileMapLayer.set_cell(Vector2i(0, 0), 1, Vector2i(3, 0))
	elif length == 2:
		$TileMapLayer.set_cell(Vector2i(0, 0), 1, Vector2i(0, 0))
		$TileMapLayer.set_cell(Vector2i(1, 0), 1, Vector2i(2, 0))
	elif length >= 3:
		$TileMapLayer.set_cell(Vector2i(0, 0), 1, Vector2i(0, 0))
		for i in range(length-2):
			$TileMapLayer.set_cell(Vector2i(1+i, 0), 1, Vector2i(1, 0))
		$TileMapLayer.set_cell(Vector2i(length-1, 0), 1, Vector2i(2, 0))
	
	
func action():
	$'AnimationPlayer'.speed_scale = 1
	var directions = [".", "up", "right", "down", "left"]
	#print("%s_%s" % [directions[direction], move])
	$AnimationPlayer.play("%s_%s" % [directions[direction], move])

func reverse_action():
	var directions = [".", "up", "right", "down", "left"]
	if $'AnimationPlayer'.current_animation_position > 0.99:
		$AnimationPlayer.play_backwards("%s_%s" % [directions[direction], move])
		#$'AnimationPlayer'.speed_scale = -1
		return
	$'AnimationPlayer'.speed_scale = -1
	
	#print("%s_%s" % [directions[direction], move])
	$AnimationPlayer.play("%s_%s" % [directions[direction], move])
