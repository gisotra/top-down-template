extends CharacterBody2D
class_name Player # isso permite que o node seja editado 

# export -> Essa variável aparece para edição no INSPECTOR
@export var MaxSpeed: float

# referências a nodes filhos da cena do Player
@onready var player_sprite: AnimatedSprite2D = $PlayerSprite
@onready var hitbox: CollisionShape2D = $Hitbox
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var wrist: Node2D = $swordHandle


# variáveis usadas no código
var lastDirection: Vector2 = Vector2.DOWN
var isMoving: bool = false

func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("move_left", "move_right","move_up","move_down")
	velocity = direction * MaxSpeed
	if Input.is_action_just_pressed("attack"):
		animation_player.play("attack")
	move_and_slide()
	_handle_direction(direction)
	
func _handle_direction(direction: Vector2):
	if direction == Vector2.ZERO:
		# Checamos a "memória" para saber qual idle tocar
		if lastDirection.x != 0: 
			player_sprite.play("idle_side_direction") 
		elif lastDirection.y > 0:
			player_sprite.play("idle_down")
			wrist.rotation = 90
		elif lastDirection.y < 0:
			player_sprite.play("idle_up")
			wrist.rotation = 270
		return
		
	# se chegou até aqui, é porque ele não está parado, então atualizamos a direção anterior
	lastDirection = direction
		
	# espelhamento horizontal da sprite, dando a impressão que o player virou
	if direction.x < 0: # esquerda
		player_sprite.flip_h = false
	elif direction.x > 0: # direita
		player_sprite.flip_h = true

	if direction.x != 0:
		player_sprite.play("run_side_direction")
		if player_sprite.flip_h == true: # estou olhando pra direita
			wrist.rotation = 0
		elif player_sprite.flip_h == false:
			wrist.rotation = 180
			
	elif direction.y > 0:
		player_sprite.play("run_down")
		wrist.rotation = 90
	elif direction.y < 0: 
		player_sprite.play("run_up")
		wrist.rotation = 270
