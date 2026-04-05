extends Node2D

@export var player : Node2D
@export var textura_do_coracao : Texture2D
@export var espaco_entre_coracoes  = 20.0
@onready var container_pos: Marker2D = $container_pos

var lista_de_coracoes : Array[Sprite2D] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_criar_coracoes(player.HealthPoints)
	player.vida_mudou.connect(_atualizar_coracoes)

func _criar_coracoes(quant_max : int):
	for i in range(quant_max):
		var novo_coracao = Sprite2D.new()
		novo_coracao.texture = textura_do_coracao
		novo_coracao.hframes = 2
		novo_coracao.global_position.y = container_pos.global_position.y
		novo_coracao.global_position.x = container_pos.global_position.x + i * espaco_entre_coracoes
		add_child(novo_coracao)
		lista_de_coracoes.append(novo_coracao)
		

func _atualizar_coracoes(vida_atual: int):
	for i in range(lista_de_coracoes.size()):
		if i < vida_atual:
			lista_de_coracoes[i].frame = 0
		else: 
			lista_de_coracoes[i].frame = 1
	return
