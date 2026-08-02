package src.game.decoration.trees;

import haxe.extern.EitherType;
import src.engine.GameInfo;
import src.engine.NoiseParams;
import src.engine.compilercode.LuaArray;
import src.engine.definition.Decoration.DecorationFlags;
import src.engine.definition.Decoration.DecorationRotation;
import src.engine.definition.Decoration.DecorationSchematic;
import src.engine.definition.Decoration.SchematicDefinition;

final class SmallOakTree implements DecorationSchematic {
	public var place_on: LuaArray<String> = ["infdev:grass"];
	public var sidelen: Int;
	public var fill_ratio: Float = 0.5;
	public var noise_params: NoiseParams;
	public var biomes: LuaArray<String>;
	public var y_min: Int;
	public var y_max: Int;
	public var spawn_by: LuaArray<String>;
	public var check_offset: Int;
	public var num_spawn_by: Int;
	public var flags: LuaArray<DecorationFlags> = [SchematicFlagsPlaceCenterX, SchematicFlagsPlaceCenterZ];
	public var schematic: EitherType<String, SchematicDefinition> = GameInfo.schematicPath + "small_oak_tree.mts";
	public var replacements: Dynamic;
	public var rotation: DecorationRotation;
	public var place_offset_y: Int;
}
