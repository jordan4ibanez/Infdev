-- Entry point into what makes up the world.

infdev = infdev or {}

-- Turns everything into a light source.
local debug_mode = false

--- Custom node registration.
---@param name string
---@param definition table
function infdev.register_node(name, definition)
	if (debug_mode) then
		definition.light_source = 14
	end

	-- definition.groups = definition.groups or {}
	-- definition.groups.dig_immediate = 3

	core.register_node(":infdev:" .. name, definition)
end

infdev.groups = {
	wood = "wood",
	stone = "stone",
	soil = "soil",
	sand = "sand",
	plant = "plant",
	farmland = "farmland",
	bedrock = "bedrock",
	liquid_source = "liquid_source",
	liquid_flow = "liquid_flow",
	water = "water"
}


infdev.register_node("stone", {
	tiles = { "default_stone.png" },
	groups = { [infdev.groups.stone] = 1 }
})

infdev.register_node("cobblestone", {
	tiles = { "default_cobble.png" },
	groups = { [infdev.groups.stone] = 1 }
})

infdev.register_node("dirt", {
	tiles = { "default_dirt.png" },
	groups = { [infdev.groups.soil] = 1 }
})

infdev.register_node("grass", {
	tiles = {
		"default_grass.png",
		"default_dirt.png",
		{
			name = "default_dirt.png^default_grass_side.png",
			tileable_vertical = false
		}
	},
	groups = { [infdev.groups.soil] = 2 }
})

infdev.register_node("sand", {
	tiles = { "default_sand.png" },
	groups = { [infdev.groups.sand] = 1 }
})

infdev.register_node("coal", {
	tiles = { "default_stone.png^default_mineral_coal.png" },
	groups = { [infdev.groups.stone] = 2 }
})

infdev.register_node("iron", {
	tiles = { "default_stone.png^default_mineral_iron.png" },
	groups = { [infdev.groups.stone] = 2 }
})

infdev.register_node("gold", {
	tiles = { "default_stone.png^default_mineral_gold.png" },
	groups = { [infdev.groups.stone] = 3 }
})

infdev.register_node("diamond", {
	tiles = { "default_stone.png^default_mineral_diamond.png" },
	groups = { [infdev.groups.stone] = 4 }
})

infdev.register_node("ruby", {
	tiles = { "default_stone.png^(default_mineral_diamond.png^[colorize:red:190)" },
	groups = { [infdev.groups.stone] = 5 }
})

infdev.register_node("sapphire", {
	tiles = { "default_stone.png^(default_mineral_diamond.png^[colorize:blue:190)" },
	groups = { [infdev.groups.stone] = 6 }
})

infdev.register_node("emerald", {
	tiles = { "default_stone.png^(default_mineral_diamond.png^[colorize:lime:190)" },
	groups = { [infdev.groups.stone] = 7 }
})

infdev.register_node("lapis", {
	tiles = { "default_stone.png^((default_mineral_coal.png^[invert:rgb^[contrast:100:-70)^[colorize:blue:150)" },
	groups = { [infdev.groups.stone] = 8 }
})

infdev.register_node("moonstone", {
	tiles = { "default_stone.png^(default_mineral_iron.png^[colorize:lightblue:200)" },
	groups = { [infdev.groups.stone] = 9 }
})

infdev.register_node("bedrock", {
	tiles = { "default_stone.png^[contrast:100:-15" },
	groups = { [infdev.groups.bedrock] = 1 }
})

infdev.register_node("sandstone", {
	tiles = { "default_sandstone.png" },
	groups = { [infdev.groups.stone] = 1 }
})

infdev.register_node("cactus", {
	tiles = { "default_cactus_top.png", "default_cactus_top.png", "default_cactus_side.png" },
	groups = { [infdev.groups.plant] = 1 }
})

infdev.register_node("sugarcane", {
	drawtype = "plantlike",
	tiles = { "default_papyrus.png" },
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = { -6 / 16, -0.5, -6 / 16, 6 / 16, 0.5, 6 / 16 },
	},
	groups = { [infdev.groups.plant] = 1 }
})


infdev.register_node("oak_tree", {
	tiles = { "default_tree_top.png", "default_tree_top.png", "default_tree.png" },
	paramtype2 = "facedir",
	is_ground_content = false,
	groups = { [infdev.groups.wood] = 1 }
})

infdev.register_node("oak_leaves", {
	drawtype = "allfaces_optional",
	waving = 1,
	tiles = { "default_leaves.png" },
	special_tiles = { "default_leaves_simple.png" },
	paramtype = "light",
	is_ground_content = false,
	groups = { [infdev.groups.plant] = 1 }
})

infdev.register_node("birch_tree", {
	tiles = { "default_aspen_tree_top.png", "default_aspen_tree_top.png",
		"default_aspen_tree.png" },
	paramtype2 = "facedir",
	is_ground_content = false,
	groups = { [infdev.groups.wood] = 1 }
})


infdev.register_node("birch_leaves", {
	drawtype = "allfaces_optional",
	tiles = { "default_aspen_leaves.png" },
	waving = 1,
	paramtype = "light",
	is_ground_content = false,
	groups = { [infdev.groups.plant] = 1 }
})


infdev.register_node("water_source", {
	description = "Water Source",
	drawtype = "liquid",
	waving = 3,
	tiles = {
		{
			name = "default_water_source_animated.png",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 2.0,
			},
		},
		{
			name = "default_water_source_animated.png",
			backface_culling = true,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 2.0,
			},
		},
	},
	use_texture_alpha = "blend",
	paramtype = "light",
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	is_ground_content = false,
	drop = "",
	drowning = 1,
	liquidtype = "source",
	liquid_alternative_flowing = "infdev:water_flowing",
	liquid_alternative_source = "infdev:water_source",
	liquid_viscosity = 1,
	post_effect_color = { a = 103, r = 30, g = 60, b = 90 },
	groups = {
		[infdev.groups.liquid_source] = 1,
		[infdev.groups.water] = 1,
	},
	-- sounds = default.node_sound_water_defaults(),
})


infdev.register_node("water_flowing", {
	description = "Flowing Water",
	drawtype = "flowingliquid",
	waving = 3,
	tiles = { "default_water.png" },
	special_tiles = {
		{
			name = "default_water_flowing_animated.png",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 0.5,
			},
		},
		{
			name = "default_water_flowing_animated.png",
			backface_culling = true,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 0.5,
			},
		},
	},
	use_texture_alpha = "blend",
	paramtype = "light",
	paramtype2 = "flowingliquid",
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	is_ground_content = false,
	drop = "",
	drowning = 1,
	liquidtype = "flowing",
	liquid_alternative_flowing = "infdev:water_flowing",
	liquid_alternative_source = "infdev:water_source",
	liquid_viscosity = 1,
	post_effect_color = { a = 103, r = 30, g = 60, b = 90 },
	groups = {
		[infdev.groups.liquid_flow] = 1,
		[infdev.groups.water] = 1,
	},
	-- sounds = default.node_sound_water_defaults(),
})
