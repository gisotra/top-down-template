extends CharacterBody2D
class_name Enemy

@onready var ap: AnimationPlayer = $AnimationPlayer

@export var enemy_speed : float
@onready var navigation_agent_2d: NavigationAgent2D = $NavigationAgent2D
@onready var health_component: HealthComponent = $HealthComponent
@onready var sprite: Sprite2D = $enemy_sprite

var stopMoving :bool = false
var isDead :bool = false
var player_ref : Node2D 

func _ready() -> void:
	stopMoving = false
	player_ref = get_tree().get_first_node_in_group("playergroup")
	GameManager.player_morreu.connect(_parar_de_se_mover)

func _physics_process(delta: float) -> void:
	if isDead or stopMoving: return
	var dir = to_local(navigation_agent_2d.get_next_path_position()).normalized()
	if dir > Vector2.ZERO: 
		sprite.flip_h = true
	else: 
		sprite.flip_h = false
	velocity = dir * enemy_speed

	#global_position = lerp(global_position, player_ref.global_position, delta )
	move_and_slide()

func makepath() -> void:
	navigation_agent_2d.target_position = player_ref.global_position

func _hurt():
	var originalColor = Color.WHITE
	sprite.modulate = Color.RED
	var tween = create_tween()
	tween.tween_property(sprite, "modulate", originalColor, 0.3 )

func _on_timer_timeout() -> void:
	makepath()

func _on_health_component_on_die() -> void:
	isDead = true
	ap.play("dead")

func _on_health_component_on_take_damage(current_health_value: float) -> void:
	_hurt() 
	
func _parar_de_se_mover():
	stopMoving = true
