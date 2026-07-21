package src.game.ore;

import src.engine.definition.OreDefinition;
import src.game.groups.NodeGroup;
import src.game.node.stone.StoneSound;

@:register("infdev:diamond_ore")
final class DiamondOre extends OreDefinition {
	public function new() {
		super();

		this.nodeGroups = [
			NodeGroupStone => 3
		];

		this.tiles = ["default_stone.png^default_mineral_diamond.png"];

		this.nodeSounds = StoneSound.get();

		// todo: make this an actual item
		this.drop = "infdev:diamond";

		this.oreSpawns = [{
			ore_type: OreTypeScatter,
			wherein: "infdev:stone",
			clust_scarcity: 15,
			clust_num_ores: 7,
			clust_size: 3,
			y_max: -256,
			y_min: -1023,
		}];
	}
}
