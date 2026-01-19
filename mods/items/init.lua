-- The items in the game.

-- Generation of pickaxe, shovel, axe, sword, hoe, shears, and paxel.

local __item_material = {
	wood = {
		color_mod = "#966919"
	},
	coal = {
		color_mod = "#000000"
	},
	stone = {
		color_mod = "#505050"
	},
	iron = {
		color_mod = "#D0D0D0"
	},
	gold = {
		color_mod = "#EFBF04"
	},
	diamond = {
		color_mod = "#00BFFF"
	},
	ruby = {
		color_mod = "#FF0000"
	},
	sapphire = {
		color_mod = "#0000FF"
	},
	emerald = {
		color_mod = "#00FF00"
	},
	lapis = {
		color_mod = "#00008B"
	},
	moonstone = {
		color_mod = "#ADD8E6"
	}
}

local level = 0
for material, definition in pairs(__item_material) do
	level = level + 1

	core.register_tool(":infdev:" .. material .. "_axe", {
		inventory_image = "default_tool_axe_head.png^[colorize:" ..
			definition.color_mod .. ":200^default_tool_axe_handle.png",
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
