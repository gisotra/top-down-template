extends Area2D
class_name InteractionArea
@onready var button: Sprite2D = $hoverButton
@onready var speech_bubble: Sprite2D = $"../SpeechBubble"
@onready var camera : GameCamera = get_tree().get_first_node_in_group("camera")

var  interactableBody : Node2D = null
	
func _ready() -> void:
	button.scale = Vector2.ZERO

func _process(delta: float) -> void:
		if interactableBody != null and Input.is_action_just_pressed("interact"):
			if owner.has_method("falar"): # no caso, o Bisão
				owner.falar()

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("_interact"):
		interactableBody = body
		var mytween = create_tween()
		mytween.set_parallel(true)
		mytween.set_ease(Tween.EASE_OUT)
		mytween.set_trans(Tween.TRANS_SPRING)
		mytween.tween_property(button, "global_scale", Vector2(1.0, 1.0), 0.3)
			
func _on_body_exited(body: Node2D) -> void:
	if body.has_method("_interact"):
		if interactableBody == body:
			interactableBody = null
		var mytween = create_tween()
		mytween.set_parallel(true)
		mytween.set_ease(Tween.EASE_OUT)
		mytween.set_trans(Tween.TRANS_SPRING)
		mytween.tween_property(button, "global_scale", Vector2.ZERO, 0.3)
		
