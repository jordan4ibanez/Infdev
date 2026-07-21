package src.game.ore;

import src.engine.definition.OreDefinition;
import src.game.groups.NodeGroup;
import src.game.node.stone.StoneSound;

@:register("infdev:sapphire_ore")
final class SapphireOre extends OreDefinition {
	public function new() {
		super();

		this.nodeGroups = [
			NodeGroupStone => 5
		];

		this.tiles = ["default_stone.png^(default_mineral_diamond.png^[colorize:blue:190)"];

		this.nodeSounds = StoneSound.get();

		// todo: make this an actual item
		this.drop = "infdev:sapphire";

		this.oreSpawns = [{
			ore_type: OreTypeScatter,
			wherein: "infdev:stone",
			clust_scarcity: 18,
			clust_num_ores: 7,
			clust_size: 3,
			y_max: -384,
			y_min: -1023,
		}];
	}
}
