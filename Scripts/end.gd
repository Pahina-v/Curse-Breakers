extends Node2D

@onready var root = get_node("/root/Main")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if not body.name == "CharacterBody2D":
		return
	root.next_level()
