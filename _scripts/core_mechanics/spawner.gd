extends Node2D
class_name SpawnManager

@export var Enemy : PackedScene
@export var world_tiles : TileMapLayer

# Esse método será chamado toda vez que o timer de 2 segundos se encerrar.
func _on_spawn_timer_timeout() -> void:
	_spawnarInimigo()

func _spawnarInimigo():
	if Enemy == null or world_tiles == null:
		return
	
	var novo_inimigo = Enemy.instantiate()
	novo_inimigo.global_position = _sortear_posicao_no_mundo()
	add_child(novo_inimigo)


func _sortear_posicao_no_mundo() -> Vector2:
	var retangulo = world_tiles.get_used_rect()
	var tamanho_do_tile = world_tiles.tile_set.tile_size
	
	var pixel_de_inicio_X = retangulo.position.x * tamanho_do_tile.x
	var pixel_de_inicio_Y = retangulo.position.y * tamanho_do_tile.y
	
	var pixel_de_fim_X = retangulo.end.x * tamanho_do_tile.x
	var pixel_de_fim_Y = retangulo.end.y * tamanho_do_tile.y
	
	# agora o sorteio dentro dos limites estabelecidos acima
	var randomX = randf_range(pixel_de_inicio_X, pixel_de_fim_X)
	var randomY = randf_range(pixel_de_inicio_Y, pixel_de_fim_Y)
	
	var posicao_sorteada = Vector2(randomX, randomY)
	return posicao_sorteada
	
	
