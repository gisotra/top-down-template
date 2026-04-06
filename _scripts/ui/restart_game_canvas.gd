extends CanvasLayer

# ui que tem o papel de mostrar o botão de restart no momento que o player for morto
@onready var background: ColorRect = $background

var canClick: bool = false

func _ready() -> void:
	GameManager.game_over.connect(_can_restart)
	hide()


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("restart") and canClick:
		get_tree().reload_current_scene() # reinicia o jogo


func _appear():
	var myTween = create_tween()
	
	myTween.set_ease(Tween.EASE_IN)
	myTween.set_trans(Tween.TRANS_LINEAR)
	#amyTween.tween_property(background, )
	show() 

func _can_restart():
	_appear()
	canClick = true
