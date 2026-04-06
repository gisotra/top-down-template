extends StaticBody2D

@onready var sprite: Sprite2D = $Sprite2D


func iniciarPartida():
	GameManager.comece_a_partida.emit() # alerta o rádio global de que DEVE SE INICIAR a partida
	sprite.frame = 1
	
