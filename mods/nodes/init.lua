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

	definition.stack_max = definition.stack_max or 64

	core.register_node(":infdev:" .. name, definition)
end

local mod_path = core.get_modpath(core.get_current_modname())

dofile(mod_path .. "/ores.lua")
dofile(mod_path .. "/furnace.lua")
dofile(mod_path .. "/blast_furnace.lua")




infdev.register_node("stone", {
	tiles = { "default_stone.png" },
	drop = "infdev:cobblestone",
	groups = { [infdev.groups.stone] = 1 }
})

infdev.register_node("cobblestone", {
	tiles = { "default_cobble.png" },
	groups = {
		[infdev.groups.stone] = 1,
		[infdev.groups.cobblestone] = 1
	}
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
	groups = { [infdev.groups.soil] = 1 },
	drop = "infdev:dirt"
})

infdev.register_node("sand", {
	tiles = { "default_sand.png" },
	groups = { [infdev.groups.sand] = 1 }
})

infdev.register_node("clay_block", {
	description = "Clay Block",
	tiles = { "default_clay.png" },
	groups = { [infdev.groups.soil] = 1 },
	drop = "infdev:clay 4",
})

infdev.register_node("brick_block", {
	description = "Brick Block",
	tiles = {
		"default_brick.png^[transformFX",
		"default_brick.png",
	},
	is_ground_content = false,
	groups = { [infdev.groups.stone] = 1 },
})

infdev.register_node("fireclay_brick_block", {
	description = "Fireclay Brick Block",
	tiles = {
		"default_brick.png^[transformFX^[colorize:#988558:200",
		"default_brick.png^[colorize:#988558:200",
	},
	is_ground_content = false,
	groups = { [infdev.groups.stone] = 1 },
})

infdev.register_node("glass", {
	description = "Glass",
	drawtype = "glasslike_framed_optional",
	tiles = { "default_glass.png", "default_glass_detail.png" },
	use_texture_alpha = "clip", -- Only needed for stairs API.
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = false,
	groups = { [infdev.groups.glass] = 1 },
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
	groups = {
		[infdev.groups.wood] = 1,
		[infdev.groups.tree] = 1
	}
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

infdev.register_node("oak_planks", {
	tiles = { "default_wood.png" },
	groups = {
		[infdev.groups.wood] = 1,
		[infdev.groups.planks] = 1
	}
})

infdev.register_node("birch_tree", {
	tiles = { "default_aspen_tree_top.png", "default_aspen_tree_top.png",
		"default_aspen_tree.png" },
	paramtype2 = "facedir",
	is_ground_content = false,
	groups = {
		[infdev.groups.wood] = 1,
		[infdev.groups.tree] = 1
	}
})


infdev.register_node("birch_leaves", {
	drawtype = "allfaces_optional",
	tiles = { "default_aspen_leaves.png" },
	waving = 1,
	paramtype = "light",
	is_ground_content = false,
	groups = { [infdev.groups.plant] = 1 }
})

infdev.register_node("birch_planks", {
	tiles = { "default_aspen_wood.png" },
	groups = {
		[infdev.groups.wood] = 1,
		[infdev.groups.planks] = 1
	}
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
