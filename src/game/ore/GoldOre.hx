package src.game.ore;

import src.engine.definition.OreDefinition;
import src.game.groups.NodeGroup;
import src.game.node.stone.StoneSound;

@:register("infdev:gold_ore")
final class GoldOre extends OreDefinition {
	public function new() {
		super();

		this.nodeGroups = [
			NodeGroupStone => 3
		];

		this.tiles = ["default_stone.png^default_mineral_gold.png"];

		this.nodeSounds = StoneSound.get();

		// todo: make this an actual item
		this.drop = "infdev:gold";

		this.oreSpawns = [{
			ore_type: OreTypeScatter,
			wherein: "infdev:stone",
			clust_scarcity: 14,
			clust_num_ores: 5,
			clust_size: 3,
			y_max: -128,
			y_min: -1023,
		}];
	}
}
