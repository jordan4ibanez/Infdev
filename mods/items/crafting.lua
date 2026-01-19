-- Craft recipes are stored here.

core.register_craft({
	output = "infdev:oak_planks 4",
	recipe = {
		{ "infdev:oak_tree" },
	}
})

core.register_craft({
	output = "infdev:birch_planks 4",
	recipe = {
		{ "infdev:birch_tree" },
	}
})

core.register_craft({
	output = "infdev:stick 4",
	recipe = {
		{ "group:" .. infdev.groups.planks },
		{ "group:" .. infdev.groups.planks },
	}
})

core.register_craft({
	output = "infdev:furnace",
	recipe = {
		{ "group:" .. infdev.groups.cobblestone, "group:" .. infdev.groups.cobblestone, "group:" .. infdev.groups.cobblestone },
		{ "group:" .. infdev.groups.cobblestone, "",                                    "group:" .. infdev.groups.cobblestone },
		{ "group:" .. infdev.groups.cobblestone, "group:" .. infdev.groups.cobblestone, "group:" .. infdev.groups.cobblestone },
	}
})
