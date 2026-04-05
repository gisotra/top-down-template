extends Node2D
class_name HealthComponent

signal on_change(current : int, max : int)
signal on_take_damage(current_health_value: float)
signal on_die

@onready var hb: HealthBar = $HealthBar

@onready var current_health : float: 
	set(value):
		current_health = value

@export var maxHealth : float:
	set(value):
		maxHealth = value
		if current_health > maxHealth:
			maxHealth = current_health

@export var drop_on_death : PackedScene

func _ready():
	current_health = maxHealth

func _take_damage(damage : float):
	current_health -= damage
	on_change.emit(current_health, max)
	on_take_damage.emit(current_health)
	
	if current_health <= 0.0:
		emit_signal("on_die")

func heal(amount: float):
	_take_damage(-amount)

func initHealth():
	current_health = maxHealth
