-- Decorations for the terrain.

core.register_decoration({
	name = "infdev:cactus",
	deco_type = "simple",
	place_on = { "infdev:sand" },
	sidelen = 16,
	noise_params = {
		offset = -0.001,
		scale = 0.022,
		spread = { x = 36, y = 36, z = 36 },
		octaves = 3,
		persist = 0.4,
		lacunarity = 5.0,
	},
	decoration = "infdev:cactus",
	height = 1,
	height_max = 3,
})

core.register_decoration({
	name = "infdev:sugarcane",
	deco_type = "simple",
	place_on = { "infdev:sand" },
	sidelen = 16,
	noise_params = {
		offset = 0.035,
		scale = 0.023,
		spread = { x = 35, y = 35, z = 35 },
		octaves = 2,
		persist = 0.2,
		lacunarity = 6.0,
	},
	decoration = "infdev:sugarcane",
	height = 2,
	height_max = 4,
	spawn_by = "infdev:water_source",
	num_spawn_by = 1,
})
