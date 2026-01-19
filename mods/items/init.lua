-- The items in the game.

infdev = infdev or {}

-- Generation of pickaxe, shovel, axe, sword, hoe, shears, and paxel.

local __item_material = {
	{
		name = "wood",
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

local level = 1
local uses = 64

-- Maxes out at the highest tool tier.
infdev.level_max = 10


for _, definition in ipairs(__item_material) do
	local material = definition.material

	print(material)

	core.register_tool(":infdev:" .. material .. "_axe", {
		inventory_image = "default_tool_axe_head.png^[colorize:" ..
			definition.color_mod .. ":200^default_tool_axe_handle.png",
		tool_capabilities = {
			max_drop_level = level,
			groupcaps = {
				cracky = {
					times = { [3] = 1.60 },
					uses = definition.uses or uses,
					maxlevel = 100
				},
			},
			damage_groups = { fleshy = 2 },
		},
		sound = { breaks = "default_tool_breaks" },
		groups = { pickaxe = 1, flammable = 2 }
	})

	level = level + 1
	uses = uses * 2
end
