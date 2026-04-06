extends Node

signal player_morreu
signal comece_a_partida
signal game_over

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
