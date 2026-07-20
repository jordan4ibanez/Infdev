package src.game.ore;

import src.engine.definition.OreDefinition;
import src.game.groups.NodeGroup;
import src.game.node.stone.StoneSound;

@:register("infdev:iron_ore")
final class IronOre extends OreDefinition {
	public function new() {
		super();

		this.nodeGroups = [
			NodeGroupStone => 1
		];

		this.tiles = ["default_stone.png^default_mineral_iron.png"];

		this.nodeSounds = StoneSound.get();

		// todo: make this an actual item
		this.drop = "infdev:iron";

		this.oreSpawns = [{
			ore_type: OreTypeScatter,
			wherein: "infdev:stone",
			clust_scarcity: 10,
			clust_num_ores: 8,
			clust_size: 3,
			y_max: 160,
			y_min: -1023,
		}];
	}
}
