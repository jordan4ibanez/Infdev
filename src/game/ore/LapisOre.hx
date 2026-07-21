package src.game.ore;

import src.engine.definition.OreDefinition;
import src.game.groups.NodeGroup;
import src.game.node.stone.StoneSound;

@:register("infdev:lapis_ore")
final class LapisOre extends OreDefinition {
	public function new() {
		super();

		this.nodeGroups = [
			NodeGroupStone => 8
		];

		this.tiles = ["default_stone.png^((default_mineral_coal.png^[invert:rgb^[contrast:100:-70)^[colorize:darkblue:150)"];

		this.nodeSounds = StoneSound.get();

		// todo: make this an actual item
		this.drop = "infdev:lapis";

		this.oreSpawns = [{
			ore_type: OreTypeScatter,
			wherein: "infdev:stone",
			clust_scarcity: 24,
			clust_num_ores: 7,
			clust_size: 3,
			y_max: -640,
			y_min: -1023,
		}];
	}
}
