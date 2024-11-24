extends Node2D

@export var platform: Node
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$TileMapLayer.set_cell(Vector2i(0, 0), 1, Vector2i(0, 0))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_area_2d_body_entered(body: Node2D) -> void:
	pass


func _on_area_2d_area_entered(area: Area2D) -> void:
	#print(area.name)
	if not area.name == "Hurtbox":
		return
	platform.action()
	$TileMapLayer.set_cell(Vector2i(0, 0), 1, Vector2i(1, 0))


func _on_area_2d_area_exited(area: Area2D) -> void:
	if not area.name == "Hurtbox":
		return
	platform.reverse_action()
	$TileMapLayer.set_cell(Vector2i(0, 0), 1, Vector2i(0, 0))
