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

	-- This is specific for "wood" to become "wooden".
	local name = (definition.name or definition.material)

	-- Create every tool from the same template.
	for tool_name, tool_groups in pairs(tool_types) do
		local groupcaps = {}

		-- This is in case new group types are added in.
		for _, group in ipairs(tool_groups) do
			groupcaps[group] = {
				times = times,
				uses = definition.uses or uses,
			}
		end

		core.register_tool(":infdev:" .. name .. "_" .. tool_name, {
			description = name:gsub("^%l", string.upper) ..
				" " .. tool_name:gsub("^%l", string.upper),
			inventory_image = "default_tool_" .. tool_name .. "_head.png^[colorize:" ..
				definition.color_mod .. ":200^default_tool_" .. tool_name .. "_handle.png",
			tool_capabilities = {
				max_drop_level = definition.level,
				groupcaps = groupcaps,
				damage_groups = { fleshy = 2 },
			},
			sound = { breaks = "default_tool_breaks" },
			-- groups = { pickaxe = 1, flammable = 2 }
		})
	end



	uses = uses * 2
end
