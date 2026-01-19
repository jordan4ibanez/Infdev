-- The items in the game.

infdev = infdev or {}

-- Generation of pickaxe, shovel, axe, sword, hoe, shears, and paxel.

local __item_material = {
	{
		name = "wooden",
		material = "wood",
		color_mod = "#966919",
		level = 1,
	},
	{
		name = "coal",
		color_mod = "#000000",
		level = 2,
	},
	{
		name = "stone",
		color_mod = "#505050",
		level = 2,
	},
	{
		name = "gold",
		color_mod = "#EFBF04",
		uses = 64,
		level = 3,
	},
	{
		name = "iron",
		color_mod = "#D0D0D0",
		level = 4,
	},
	{
		name = "diamond",
		color_mod = "#00BFFF",
		level = 5,
	},
	{
		name = "ruby",
		color_mod = "#FF0000",
		level = 6,
	},
	{
		name = "sapphire",
		color_mod = "#0000FF",
		level = 7,
	},
	{
		name = "emerald",
		color_mod = "#00FF00",
		level = 8,
	},
	{
		name = "lapis",
		color_mod = "#00008B",
		level = 9,
	},
	{
		name = "moonstone",
		color_mod = "#ADD8E6",
		level = 10,
	}
}


local uses = 64

-- Maxes out at the highest tool tier.
infdev.level_max = 10

local tool_types = {
	axe = { infdev.groups.wood },
	pickaxe = { infdev.groups.stone },
	shovel = { infdev.groups.farmland, infdev.groups.soil, infdev.groups.sand }
}

for _, definition in ipairs(__item_material) do
	local material = definition.material or definition.name

	local current_level_time = 2
	local current_time = current_level_time

	local times = {}

	-- As you level up your low level mining speed gets quite crazy.
	for i = definition.level, 1, -1 do
		times[i] = current_time
		current_time = current_time / 1.5
	end

	current_time = current_level_time

	-- As you try to mine above your current level, the times get very long.
	for i = definition.level, infdev.level_max do
		times[i] = current_time
		current_time = current_time * 3
	end

	local name = (definition.name or definition.material)

	core.register_tool(":infdev:" .. material .. "_axe", {
		description = (definition.name or definition.material):gsub("^%l", string.upper) .. " Axe",
		inventory_image = "default_tool_axe_head.png^[colorize:" ..
			definition.color_mod .. ":200^default_tool_axe_handle.png",
		tool_capabilities = {
			max_drop_level = definition.level,
			groupcaps = {
				[infdev.groups.wood] = {
					times = times,
					uses = definition.uses or uses,
					-- maxlevel = 100
				},
			},
			damage_groups = { fleshy = 2 },
		},
		sound = { breaks = "default_tool_breaks" },
		groups = { pickaxe = 1, flammable = 2 }
	})

	core.register_tool(":infdev:" .. material .. "_pickaxe", {
		description = (definition.name or definition.material):gsub("^%l", string.upper) .. " Axe",
		inventory_image = "default_tool_pickaxe_head.png^[colorize:" ..
			definition.color_mod .. ":200^default_tool_pickaxe_handle.png",
		tool_capabilities = {
			max_drop_level = definition.level,
			groupcaps = {
				[infdev.groups.stone] = {
					times = times,
					uses = definition.uses or uses,
					-- maxlevel = 100
				},
			},
			damage_groups = { fleshy = 2 },
		},
		sound = { breaks = "default_tool_breaks" },
		groups = { pickaxe = 1, flammable = 2 }
	})


	uses = uses * 2
end
