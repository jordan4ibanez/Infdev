package src.engine.definition;

import src.engine.compilercode.LuaArray;

enum abstract OreType(String) to String {
	var OreTypeScatter = "scatter";
	var OreTypeSheet = "sheet";
	var OreTypePuff = "puff";
	var OreTypeBlob = "blob";
	var OreTypeVein = "vein";
	var OreTypeStratum = "stratum";
}

typedef OreSpawn = {
	// todo: this should automatically inject itself.
	// todo: make everything optional
	var name: String;
	var ore_type: OreType;
	// Ore node to place
	var ore: String;
	var ore_param2: Param2;
	var wherein: String;
	// Node to place ore in. Multiple are possible by passing a list.
	var clust_scarcity: Int;
	// Ore has a 1 out of clust_scarcity chance of spawning in a node.
	// If the desired average distance between ores is 'd', set this to
	// d * d * d.
	// Integer in range [u32]
	var clust_num_ores: Int;
	// Amount of ores in a cluster.
	// Integer in range: [0, 32767]
	var clust_size: Int;
	// Size of the bounding box of the cluster.
	// Integer in range: [0, 32767].
	// In this example, there is a 3 * 3 * 3 cluster where 8 out of the 27
	// nodes are coal ore.
	var y_min: Int;
	var y_max: Int;
	// Lower and upper limits for ore (inclusive).
	// Integer [s16]
	var flags: String;
	// Attributes for the ore generation, see 'Ore attributes' section above
	var noise_threshold: Int;
	var noise_params: NoiseParams;
	var biomes: LuaArray<String>;
	// List of biomes in which this ore occurs.
	// Occurs in all biomes if this is omitted, and ignored if the Mapgen
	// being used does not support biomes.
	// Can be a list of (or a single) biome names, IDs, or definitions.
	// Type-specific parameters
	// "sheet"
	var column_height_min: Int;
	var column_height_max: Int;
	var column_midpoint_factor: Float;
	// "puff"
	var np_puff_top: NoiseParams;
	var np_puff_bottom: NoiseParams;
	// "vein"
	var random_factor: Float;
	// "stratum"
	var np_stratum_thickness: NoiseParams;
	var stratum_thickness: Int;
	// only used if no noise defined
	// integer [u16]
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
	var spawns: LuaArray<OreSpawn>;

	public function new() {
		super();
	}
}
