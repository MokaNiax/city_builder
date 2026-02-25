extends TileMapLayer

func _ready():
	randomize_all_tiles()

func randomize_all_tiles():
	var cells = get_used_cells()

	for coords in cells:
		var source_id = get_cell_source_id(coords)

		if source_id != 0:
			continue

		var atlas_coords = get_cell_atlas_coords(coords)
		var random_rotation = randi() % 4

		set_cell(coords, source_id, atlas_coords, random_rotation)
