class_name GameVar extends Node2D

var timer: Timer

var money: int = 20
var population: int = 0

func _ready() -> void:
	timer = Timer.new()
	timer.wait_time = 5.0
	timer.autostart = true
	add_child(timer)
	
	if timer != null:
		timer.timeout.connect(_on_timeout)
	else:
		print("Erreur : Le nœud Timer est introuvable !")

func _on_timeout() -> void:
	var houses = get_tree().get_nodes_in_group("house")
	
	if not houses.is_empty():
		for house in houses:
			Game.add_money(house.get_meta("rent_value"))

func add_money(value: int) -> void:
	money += value

func sub_money(value: int) -> void:
	money -= value

func add_population(value: int) -> void:
	population += value

func sub_population(value: int) -> void:
	population -= value
