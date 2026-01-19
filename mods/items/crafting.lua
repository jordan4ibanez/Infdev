-- Craft recipes are stored here.

local group_string = infdev.group_string

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
		{ group_string(infdev.groups.planks) },
		{ group_string(infdev.groups.planks) },
	}
})

core.register_craft({
	output = "infdev:furnace",
	recipe = {
		{ group_string(infdev.groups.cobblestone), group_string(infdev.groups.cobblestone), group_string(infdev.groups.cobblestone) },
		{ group_string(infdev.groups.cobblestone), "",                                      group_string(infdev.groups.cobblestone) },
		{ group_string(infdev.groups.cobblestone), group_string(infdev.groups.cobblestone), group_string(infdev.groups.cobblestone) },
	}
})
