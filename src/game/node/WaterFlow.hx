package src.game.node;

import src.engine.definition.graphics.RGBA;
import src.engine.definition.graphics.TileAnimationDefinition.TileAnimationDefinitionVerticalFrames;
import src.engine.definition.basic.NodeDropTable;
import src.engine.definition.ToolCapabilities.GroupCapabilities;
import src.engine.definition.basic.TileDefinition;
import src.engine.definition.NodeDefinition;
import src.game.groups.NodeGroup;

@:register("infdev:water_flow")
final class WaterFlow extends NodeDefinition {
	public function new() {
		super();

		description = "Flowing Water";
		drawType = DrawTypeFlowingLiquid;
		waving = WavingTypeLiquids;
		// tiles = { "default_water.png" },
		// special_tiles = {
		// 	{
		// 		name = "default_water_flowing_animated.png",
		// 		backface_culling = false,
		// 		animation = {
		// 			type = "vertical_frames",
		// 			aspect_w = 16,
		// 			aspect_h = 16,
		// 			length = 0.5,
		// 		},
		// 	},
		// 	{
		// 		name = "default_water_flowing_animated.png",
		// 		backface_culling = true,
		// 		animation = {
		// 			type = "vertical_frames",
		// 			aspect_w = 16,
		// 			aspect_h = 16,
		// 			length = 0.5,
		// 		},
		// 	},
		// },
		// use_texture_alpha = "blend",
		// paramtype = "light",
		// paramtype2 = "flowingliquid",
		// walkable = false,
		// pointable = false,
		// diggable = false,
		// buildable_to = true,
		// is_ground_content = false,
		// drop = "",
		// drowning = 1,
		// liquidtype = "flowing",
		// liquid_alternative_flowing = "infdev:water_flowing",
		// liquid_alternative_source = "infdev:water_source",
		// liquid_viscosity = 1,
		// post_effect_color = { a = 103, r = 30, g = 60, b = 90 },
		// groups = {
		// 	[infdev.groups.liquid_flow] = 1,
		// 	[infdev.groups.water] = 1,
		// },
		// -- sounds = default.node_sound_water_defaults(),
	}
}
