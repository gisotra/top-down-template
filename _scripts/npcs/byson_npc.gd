extends Sprite2D
class_name NPC_Byson

@export_multiline var texto_de_dialogo = "Olá viajante! É um ótimo dia para aprender a codar!"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func falar():
	var caixaDeTexto = get_tree().get_nodes_in_group("caixa_de_dialogo")
	# esse método retorna um array de todos os nodes daquele grupo
	
	if caixaDeTexto.size() > 0: # se o array for maior que 0 = tem algo ali
		var minha_caixa = caixaDeTexto[0] # pega a primeira caixa que achar, que é minha caixa de diálogo
		
		minha_caixa._mostrar_texto(texto_de_dialogo)
