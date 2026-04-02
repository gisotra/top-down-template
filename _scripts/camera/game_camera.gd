extends Camera2D
class_name GameCamera

@export var player_reference: Node2D

func _process(delta: float) -> void:
	# standard behaviour
	if player_reference != null:
		global_position = player_reference.global_position
