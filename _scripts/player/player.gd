extends CharacterBody2D
class_name Player # isso permite que o node seja editado no inspetor da Engine

# export -> Essa variável aparece para edição no INSPECTOR
@export_range(1, 10) var HealthPoints: int
@export var MaxSpeed: float

# referências a nodes filhos da cena do Player
@onready var player_sprite: AnimatedSprite2D = $PlayerSprite
@onready var hitbox: CollisionShape2D = $Hitbox
@onready var attack_animation_player: AnimationPlayer = $attack_player
@onready var wrist: Node2D = $swordHandle
@onready var slash_area: AttackArea = $swordHandle/slashCollision
@onready var state_player: AnimationPlayer = $state_player
@onready var invincibility: Timer = $Invincibility

# =================== variáveis usadas no código ===================

# estados
var lastDirection: Vector2 = Vector2.DOWN
var isMoving: bool = false
var isAttacking: bool = false
var isHurt: bool = false

# vida
var totalHealth: int
signal vida_mudou(novaVida: int) # meu próprio signal, que será chamado quando a vida do player mudar 

func _ready() -> void:
	totalHealth = HealthPoints

# =================== função chamada a cada frame do jogo ===================
func _physics_process(delta: float) -> void:
	if !invincibility.is_stopped():
		player_sprite.modulate = Color(1.0, 1.0, 1.0, 0.75)
	else:
		player_sprite.modulate = Color(1.0, 1.0, 1.0, 1.0)
		
	var direction = Input.get_vector("move_left", "move_right","move_up","move_down")
	velocity = direction * MaxSpeed
	if Input.is_action_just_pressed("attack") and !isAttacking:
		attack_animation_player.play("attack")
		isAttacking = true
	move_and_slide()
	
	# colisões
	
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()

		if collider is Enemy and not isHurt and invincibility.is_stopped():
			isHurt = true
			invincibility.start()
			player_sprite.play("hurt")
			state_player.play("hurt")
			if totalHealth > 1: 
				print("vida maior que 1")
				totalHealth -= 1
				vida_mudou.emit(totalHealth)
			else: #golpe fatal
				#player_sprite.play("dead")
				print("a tal da morte")
				totalHealth = 0
				vida_mudou.emit(totalHealth)
				state_player.play("death")

	_handle_direction(direction)
	_update_wrist_rotation()

func _handle_direction(direction: Vector2):
	if isHurt: return
	if direction == Vector2.ZERO:
		# Checamos a "memória" para saber qual idle tocar
		if lastDirection.x != 0: 
			player_sprite.play("idle_side_direction") 
		elif lastDirection.y > 0:
			player_sprite.play("idle_down")
		elif lastDirection.y < 0:
			player_sprite.play("idle_up")
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
	elif direction.y > 0:
		player_sprite.play("run_down")
		#wrist.rotation = 90
	elif direction.y < 0: 
		player_sprite.play("run_up")

func _update_wrist_rotation() -> void:
	if isAttacking:
		return

# atualizamos a posição do slash com base na ultima direção, somente se não estiver atacando
	if lastDirection.x > 0:     # direita
		wrist.rotation_degrees = 0
	elif lastDirection.x < 0:   # esquerda
		wrist.rotation_degrees = 180
	elif lastDirection.y > 0:   # baixo
		wrist.rotation_degrees = 90
	elif lastDirection.y < 0:   # cima
		wrist.rotation_degrees = 270

func _interact():
	print("teste")

# signals de colisão

# signals de animação 
func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "attack":
		isAttacking = false

func _on_animation_player_animation_started(anim_name: StringName) -> void:
	if anim_name == "attack":
		slash_area.direction = lastDirection

func _on_slash_collision_body_entered(body: Node2D) -> void:
	pass # Replace with function body.

func _on_state_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "hurt":
		isHurt = false

"""
divisão de responsabilidades:
	o player não sabe que o Hud de vida existe, ele apenas ANUNCIA globalmente, através do signal, que a vida dele mudou 
	scripts "interessados" nessa informação, como o Hud de vida, ouvem e lidam com essa data de maneira própria 
"""
