-- The items in the game.

-- Generation of pickaxe, shovel, axe, sword, hoe, shears, and paxel.

local __item_material = {
	"wood",
	"coal",
	"stone",
	"iron",
	"gold",
	"diamond",
	"ruby",
	"sapphire",
	"emerald",
	"lapis",
	"moonstone"
}

for _, material in ipairs(__item_material) do
	core.register_tool(":infdev:" .. material .. "_axe", {
		inventory_image = "default_tool_" .. material .. "pick.png",
		tool_capabilities = {
			full_punch_interval = 1.2,
			max_drop_level = 0,
			groupcaps = {
				cracky = { times = { [3] = 1.60 }, uses = 10, maxlevel = 1 },
			},
			damage_groups = { fleshy = 2 },
		},
		sound = { breaks = "default_tool_breaks" },
		groups = { pickaxe = 1, flammable = 2 }
	})
end
