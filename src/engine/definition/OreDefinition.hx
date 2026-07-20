package src.engine.definition;

import src.engine.compilercode.LuaArray;
import src.engine.definition.basic.ParamType2;

enum abstract OreType(String) to String {
	var OreTypeScatter = "scatter";
	var OreTypeSheet = "sheet";
	var OreTypePuff = "puff";
	var OreTypeBlob = "blob";
	var OreTypeVein = "vein";
	var OreTypeStratum = "stratum";
}

typedef OreSpawnDefinition = {
	// todo: this should automatically inject itself.
	// todo: make everything optional
	// Ore node to place
	// var name: String;
	// var ore: String;
	var ore_type: OreType;
	@:optional
	var ore_param2: ParamType2;
	var wherein: String;
	var clust_scarcity: Int;
	var clust_num_ores: Int;
	var clust_size: Int;
	@:optional
	var y_min: Int;
	@:optional
	var y_max: Int;
	@:optional
	var flags: String;
	@:optional
	var noise_threshold: Int;
	@:optional
	var noise_params: NoiseParams;
	@:optional
	var biomes: LuaArray<String>;
	@:optional
	var column_height_min: Int;
	@:optional
	var column_height_max: Int;
	@:optional
	var column_midpoint_factor: Float;
	@:optional
	var np_puff_top: NoiseParams;
	@:optional
	var np_puff_bottom: NoiseParams;
	@:optional
	var random_factor: Float;
	@:optional
	var np_stratum_thickness: NoiseParams;
	@:optional
	var stratum_thickness: Int;
}

/**
 * When you extend this class, you get a specialty class which is extremely interesting.
 * 
 * The extended class is wrapped in a static class.
 * 
 * Defined vars are all copied to the static class. (They are virtual final)
 * 
 * Defined methods are copied to the static class and wrapped in static methods.
 * 
 * ! Warning: Do not call an override API method unless you define it. It doesn't exist.
 * 
 * Feel free to edit your custom vars during runtime.
 * 
 * Never call another override function unless 
 * 
 * Also another note: This one is for ores. 
 * Use the ItemDefinition class for items.
 * Use the ToolDefinition class for tools.
 * Use the NodeDefinition class for nodes.
 */
@:luantiDefinitionRoot
class OreDefinition extends NodeDefinition {
	public var oreSpawns: Array<OreSpawnDefinition>;

	public function new() {
		super();
	}
}
