extends Node

var batiment_scene = preload("res://Assets/Sprites/house.tscn")
var ghost = null
var in_build = false

@export var carte_sol : TileMapLayer

func _ready() -> void:
	carte_sol = get_tree().current_scene.find_child("TileMapLayer", true, false)

func _process(_delta: float) -> void:
	if in_build and ghost != null:
		var m_pos = get_viewport().get_camera_2d().get_global_mouse_position()

		m_pos = (m_pos / 16).floor() * 16
		ghost.global_position = m_pos
		if can_pose():
			ghost.modulate = Color(0, 1, 0, 0.7)
		else:
			ghost.modulate = Color(1, 0, 0, 0.7)

func _input(event: InputEvent) -> void:
	if not in_build:
		return

	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		if can_pose():
			get_viewport().set_input_as_handled()
			build_house()

	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
		get_viewport().set_input_as_handled()
		cancel_build()

	if event.is_action_pressed("rotate"):
		if ghost != null:
			ghost.rotation_degrees += 90

func _on_pressed() -> void:
	if not in_build:
		get_viewport().set_input_as_handled()
		create_ghost()

func create_ghost():
	in_build = true
	ghost = batiment_scene.instantiate()
	ghost.modulate.a = 0.5 
	get_tree().current_scene.add_child(ghost)

func build_house():
	if ghost != null:
		ghost.modulate = Color(1, 1, 1, 1)
		ghost.modulate.a = 1.0
		ghost = null 
		in_build = false

func cancel_build():
	if ghost != null:
		ghost.queue_free()
		ghost = null
		in_build = false

func can_pose() -> bool:
	if ghost == null or carte_sol == null:
		return false
	var collision = ghost.get_overlapping_areas()

	if collision.size() > 0:
		return false
	var local_pos = carte_sol.to_local(ghost.global_position)
	var cell_pos = carte_sol.local_to_map(local_pos + Vector2(8, 8))
	var tile_data = carte_sol.get_cell_tile_data(cell_pos)

	if tile_data:
		var is_grass = tile_data.get_custom_data("type_ground") == "Grass"

		return is_grass
	return false
