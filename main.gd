extends Node

var LEVEL_COUNT = 6
var levels = []
var current = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in range(LEVEL_COUNT):
		levels.append(load("res://Scenes/Levels/%s.tscn" % i).instantiate())
	
	add_child(levels[0])
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func load_level():
	levels[current].queue_free()
	levels[current] = load("res://Scenes/Levels/%s.tscn" % current).instantiate()
	add_child(levels[current])
	Global.past_positions = [Vector2(-100, -100)]
	
func next_level():
	levels[current].queue_free()
	current += 1
	add_child(levels[current])
	Global.past_positions = [Vector2(-100, -100)]
