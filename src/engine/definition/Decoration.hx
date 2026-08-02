package src.engine.definition;

import src.engine.compilercode.LuaArray;

enum abstract DecorationFlags(String) to String {
	var DecorationFlagsLiquidSurface = "liquid_surface";
	var DecorationFlagsForcePlacement = "force_placement";
	var DecorationFlagsAllFloors = "all_floors";
	var DecorationFlagsAllCeilings = "all_ceilings";
}

@:noCompletion
@:decorationRoot
@:autoBuild(src.engine.compilercode.DecorationDuctTape.build())
interface Decoration {
	var place_on: LuaArray<String>;

	var sidelen: Int;

	var fill_ratio: Float;

	var noise_params: NoiseParams;

	// todo: Define this as an array of biomes types. When biomes are implemented properly and not just a random mapgen thing.
	var biomes: LuaArray<String>;

	var y_min: Int;
	var y_max: Int;

	var spawn_by: LuaArray<String>;

	// todo: this should probably be an enum
	var check_offset: Int;

	var num_spawn_by: Int;

	var flags: LuaArray<DecorationFlags>;
}

@:decorationRoot
interface DecorationSimple extends Decoration {
	var decoration: String;
	var height: Int;
	var height_max: Int;
	var param2: Int;
	var param2_max: Int;
	var place_offset_y: Int;
}

typedef SchematicDefinition = {
	//     size = {x = 4, y = 6, z = 4},
	//     data = {
	//         {name = "default:cobble", param1 = 255, param2 = 0},
	//         {name = "default:dirt_with_grass", param1 = 255, param2 = 0},
	//         {name = "air", param1 = 255, param2 = 0},
	//           ...
	//     },
	//     yslice_prob = {
	//         {ypos = 2, prob = 128},
	//         {ypos = 5, prob = 64},
	//           ...
	//     },
}

@:decorationRoot
interface DecorationSchematic extends Decoration {
	// ! Note: the comments flip back  to after the var name after this comment.
	// ? Schematic-type parameters
	var schematic: String;
	// If schematic is a string, it is the filepath relative to the current
	// working directory of the specified Luanti schematic file.
	// Could also be the ID of a previously registered schematic.
	// todo: schematic typedef
	// Alternative schematic specification by supplying a table. The fields
	// size and data are mandatory whereas yslice_prob is optional.
	// See 'Schematic specifier' for details.
	// todo: whatever this is
	// var replacements = {["oldname"] = "convert_to", ...},
	// Map of node names to replace in the schematic after reading it.
	// todo: schematic attributes.
	// var flags = "place_center_x, place_center_y, place_center_z",
	// Flags for schematic decorations. See 'Schematic attributes'.
	// todo: schematic rotation.
	// var rotation = "90",
	// Rotation can be "0", "90", "180", "270", or "random"
	// todo: schematic place offset.
	// var place_offset_y = 0,
	// If the flag 'place_center_y' is set this parameter is ignored.
	// Y offset of the schematic base node layer relative to the 'place_on'
	// node.
	// Can be positive or negative. Default is 0.
	// Effect is inverted for "all_ceilings" decorations.
	// Ignored by 'y_min', 'y_max' and 'spawn_by' checks, which always refer
	// to the 'place_on' node.
}

// This is simplified cause this is complicated as it is.
// typedef TreeDefinition = {
// 	var axiom: String;
// 	var trunk: String;
// 	var leaves: String;
// 	var angle: Int;
// 	var iterations: Int;
// 	var random_level: Int;
// 	var trunk_type: String;
// }
// @:decorationRoot
// interface DecorationLSystemTree extends Decoration {
// 	var treedef: TreeDefinition;
// }
