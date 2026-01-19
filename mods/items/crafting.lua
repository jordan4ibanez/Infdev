-- Craft recipes are stored here.

local string_group = infdev.string_group

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
		{ string_group(infdev.groups.planks) },
		{ string_group(infdev.groups.planks) },
	}
})

core.register_craft({
	output = "infdev:furnace",
	recipe = {
		{ string_group(infdev.groups.cobblestone), string_group(infdev.groups.cobblestone), string_group(infdev.groups.cobblestone) },
		{ string_group(infdev.groups.cobblestone), "",                                      string_group(infdev.groups.cobblestone) },
		{ string_group(infdev.groups.cobblestone), string_group(infdev.groups.cobblestone), string_group(infdev.groups.cobblestone) },
	}
})
