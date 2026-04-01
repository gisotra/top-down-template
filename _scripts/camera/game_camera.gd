extends Camera2D
class_name GameCamera

@export var player_reference: Node2D

func _process(delta: float) -> void:
	if player_reference != null:
		global_position = lerp(global_position, player_reference.global_position, delta * 10)
