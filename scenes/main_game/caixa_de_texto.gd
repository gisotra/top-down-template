extends HBoxContainer
class_name CaixaDeTexto
@onready var texto_label : RichTextLabel = $TextureRect/RichTextLabel

var writingText = false
var can_skip = false
var finishedWriting = false
var text_tween: Tween

func _ready() -> void:
	self.scale = Vector2.ZERO
	hide()

func _process(delta: float) -> void:
	if visible and Input.is_action_just_pressed("close"):
		if writingText == true: # se eu apertar enter, aparece o texto inteiro
			if text_tween and text_tween.is_valid():
				text_tween.kill()
				texto_label.visible_characters = -1 # mostro tudo
				writingText = false 
				finishedWriting = true
		elif writingText == false:
			_disappear_bubble() # escondo a caixa

func _appear_bubble():
		show()
		var mytween = create_tween()
		mytween.set_parallel(true)
		mytween.set_ease(Tween.EASE_OUT)
		mytween.set_trans(Tween.TRANS_SPRING)
		mytween.tween_property(self, "scale", Vector2(1.0, 1.0), 0.3)

func _disappear_bubble():
	
		var mytween = create_tween()
		mytween.set_parallel(true)
		mytween.set_ease(Tween.EASE_OUT)
		mytween.set_trans(Tween.TRANS_SPRING)
		mytween.tween_property(self, "scale", Vector2.ZERO, 0.3)
		if text_tween and text_tween.is_valid():
				text_tween.kill()
				texto_label.visible_characters = 0 # mostro tudo
		await mytween.finished
		hide()
		
func _mostrar_texto(new_text: String):
	_appear_bubble() # faço a caixa aparecer
	
	writingText = true
	finishedWriting = false
	
	texto_label.text = new_text 
	texto_label.visible_characters = 0
	
	var total_duration = new_text.length() * 0.05
	text_tween = create_tween()
	
	text_tween.tween_property(texto_label, "visible_characters", new_text.length(), total_duration)
	await text_tween.finished 
	writingText = false
	finishedWriting = true
	
	
	
