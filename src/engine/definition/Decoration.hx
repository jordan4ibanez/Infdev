package src.engine.definition;

import haxe.extern.EitherType;
import src.engine.compilercode.LuaArray;

enum abstract DecorationFlags(String) to String {
	var DecorationFlagsLiquidSurface = "liquid_surface";
	var DecorationFlagsForcePlacement = "force_placement";
	var DecorationFlagsAllFloors = "all_floors";
	var DecorationFlagsAllCeilings = "all_ceilings";
	// For schematics.
	var SchematicFlagsPlaceCenterX = "place_center_x";
	var SchematicFlagsPlaceCenterY = "place_center_y";
	var SchematicFlagsPlaceCenterZ = "place_center_z";
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

enum abstract DecorationRotation(String) to String {
	var DecorationRotation0 = "0";
	var DecorationRotation90 = "90";
	var DecorationRotation180 = "180";
	var DecorationRotation270 = "270";
	var DecorationRotationRandom = "random";
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
	var schematic: EitherType<String, SchematicDefinition>;
	// todo: replacements typedef
	var replacements: Dynamic; // = {["oldname"] = "convert_to", ...},
	var rotation: DecorationRotation;
	var place_offset_y: Int;
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
