extends ProgressBar
class_name HealthBar

@onready var progress_bar: ProgressBar = $ProgressBar
@onready var health: HealthComponent = $".."

	
func _ready() -> void:
	setup_bar()
	
func setup_bar():
	max_value = health.maxHealth
	value = health.maxHealth
	progress_bar.max_value = max_value
	progress_bar.value = value

func change_health_value(current_health_value: float):
	if value == current_health_value:
		pass
	progress_bar.value = current_health_value


func _on_health_component_on_take_damage(health_value) -> void:
	change_health_value(health_value)
