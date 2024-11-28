extends Node2D

var bodies = 0

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
	bodies += 1
	if bodies > 1:
		return
	platform.action()
	$TileMapLayer.set_cell(Vector2i(0, 0), 1, Vector2i(1, 0))


func _on_area_2d_area_exited(area: Area2D) -> void:
	if not area.name == "Hurtbox":
		return
	bodies -= 1
	if bodies > 0:
		return
	platform.reverse_action()
	$TileMapLayer.set_cell(Vector2i(0, 0), 1, Vector2i(0, 0))
