package src.game.ore;

import src.engine.definition.OreDefinition;
import src.game.groups.NodeGroup;
import src.game.node.stone.StoneSound;

@:register("infdev:moonstone_ore")
final class MoonstoneOre extends OreDefinition {
	public function new() {
		super();

		this.description = "Moonstone Ore";

		this.nodeGroups = [
			NodeGroupStone => 9
		];

		this.tiles = ["default_stone.png^(default_mineral_iron.png^[colorize:lightblue:200)"];

		this.nodeSounds = StoneSound.get();

		// todo: make this an actual item
		this.drop = "infdev:moonstone";

		this.oreSpawns = [{
			ore_type: OreTypeScatter,
			wherein: "infdev:stone",
			clust_scarcity: 26,
			clust_num_ores: 7,
			clust_size: 3,
			y_max: -768,
			y_min: -1023,
		}];
	}
}
