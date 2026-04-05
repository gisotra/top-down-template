extends Area2D
class_name AttackArea

@export var player_reference: Node2D 
@export var slash_damage: float
@onready var camera: GameCamera = get_tree().get_first_node_in_group("camera")
var direction = Vector2.ZERO

func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	pass

func _on_body_entered(body: Node2D) -> void:
	if body.has_node("HealthComponent"):
		var health = body.get_node("HealthComponent")
		health._take_damage(slash_damage)
		camera._trigger_shake(3)
		print("é um inimigo")
	else:
		#player.velocity -= 
		#player_reference.velocity = -direction * 50
		print("é um objeto")
