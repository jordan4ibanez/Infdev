-- The items in the game.

-- Generation of pickaxe, shovel, axe, sword, hoe, shears, and paxel.

local __item_material = {
	wood = {
		color_mod = ""
	},
	coal = {
		color_mod = ""
	},
	stone = {
		color_mod = ""
	},
	iron = {
		color_mod = ""
	},
	gold = {
		color_mod = ""
	},
	diamond = {
		color_mod = ""
	},
	ruby = {
		color_mod = ""
	},
	sapphire = {
		color_mod = ""
	},
	emerald = {
		color_mod = ""
	},
	lapis = {
		color_mod = ""
	},
	moonstone = {
		color_mod = ""
	}
}

local level = 0
for material, definition in pairs(__item_material) do
	level = level + 1

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
