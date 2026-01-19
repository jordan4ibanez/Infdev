table.copy = table.copy or error

-- Generation of pickaxe, shovel, axe, sword, hoe, shears, and paxel.

local __item_material = {
	{
		name = "wooden",
		material = "group:wood",
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
		material = "group:cobblestone",
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




-- Maxes out at the highest tool tier.
infdev.level_max = 10

local tool_types = {
	axe = { infdev.groups.wood },
	pickaxe = { infdev.groups.stone },
	shovel = { infdev.groups.farmland, infdev.groups.soil, infdev.groups.sand },
	sword = { infdev.groups.plant },
	paxel = { infdev.groups.farmland, infdev.groups.soil, infdev.groups.sand, infdev.groups.stone, infdev.groups.wood },
}

local tool_recipes = {
	axe = {
		recipes = {
			{
				{ "i", "i",            "" },
				{ "i", "infdev:stick", "" },
				{ "",  "infdev:stick", "" }
			},
			{
				{ "", "i",            "i" },
				{ "", "infdev:stick", "i" },
				{ "", "infdev:stick", "" }
			}
		}
	},
	pickaxe = {
		recipes = {
			{
				{ "i", "i",            "i" },
				{ "",  "infdev:stick", "" },
				{ "",  "infdev:stick", "" }
			},
		}
	},
	shovel = {
		recipes = {
			{
				{ "", "i",            "" },
				{ "", "infdev:stick", "" },
				{ "", "infdev:stick", "" }
			},
		}
	},
	sword = {
		recipes = {
			{
				{ "", "i",            "" },
				{ "", "i",            "" },
				{ "", "infdev:stick", "" }
			},
		}
	},
	paxel = {
		recipes = {
			{ "x", "y", "z" },
		},
		type = "shapeless"
	},
}

for _, definition in ipairs(__item_material) do
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


		local uses = 64

		for _ = 1, definition.level do
			uses = uses * 2
		end

		-- This is in case new group types are added in.
		for _, group in ipairs(tool_groups) do
			groupcaps[group] = {
				times = times,
				uses = definition.uses or uses,
			}
		end

		-- Create the tool.

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


		-- Create the craft recipe for the tool.

		local recipe_base = table.copy(tool_recipes[tool_name])

		if (recipe_base == nil) then
			error("Recipe error, does not exist!")
		end

		local material = definition.material or definition.name

		for _, recipe in ipairs(recipe_base.recipes) do
			for index, element in ipairs(recipe) do
				if (type(element) == "table") then
					for deep_index, item in ipairs(element) do
						if (item == "i") then
							local new_item = material
							if (material:sub(1, string.len("group:")) ~= "group:") then
								new_item = "infdev:" .. new_item
							end
							recipe[index][deep_index] = new_item
						end
					end
				else
					if (element == "i") then
						local new_item = material
						if (material:sub(1, string.len("group:")) ~= "group:") then
							new_item = "infdev:" .. new_item
						end
						recipe[index] = new_item
					elseif element == "x" then
						recipe[index] = "infdev:" .. name .. "_axe"
					elseif element == "y" then
						recipe[index] = "infdev:" .. name .. "_pickaxe"
					elseif element == "z" then
						recipe[index] = "infdev:" .. name .. "_shovel"
					end
				end
			end

			core.register_craft({
				output = "infdev:" .. name .. "_" .. tool_name,
				recipe = recipe,
				type = recipe_base.type
			})
		end
	end
end
