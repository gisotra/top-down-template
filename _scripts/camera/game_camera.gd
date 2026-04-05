extends Camera2D
class_name GameCamera

@export var player_reference: Node2D

var shake_fade : float = 10.0
var shake_strength: float

func _process(delta: float) -> void:
	# standard behaviour
	if player_reference != null:
		global_position = player_reference.global_position
		
	if shake_strength > 0:
		shake_strength = lerp(shake_strength, 0.0, shake_fade * delta)
		offset = Vector2(randf_range(-shake_strength, shake_strength),
					randf_range(-shake_strength, shake_strength)) 

func _trigger_shake(max_shake: float):
	shake_strength = max_shake
	

	
