extends Panel

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	$Pop.text = "👥 " + str(Game.population)
	$Money.text = "💰 " + str(Game.money)
