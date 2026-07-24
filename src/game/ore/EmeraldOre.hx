package src.game.ore;

import src.engine.definition.OreDefinition;
import src.game.groups.NodeGroup;
import src.game.node.stone.StoneSound;

@:register("infdev:emerald_ore")
final class EmeraldOre extends OreDefinition {
	public function new() {
		super();

		this.description = "Emerald Ore";

		this.nodeGroups = [
			NodeGroupStone => 7
		];

		this.tiles = ["default_stone.png^(default_mineral_diamond.png^[colorize:lime:190)"];

		this.nodeSounds = StoneSound.get();

		// todo: make this an actual item
		this.drop = "infdev:emerald";

		this.oreSpawns = [{
			ore_type: OreTypeScatter,
			wherein: "infdev:stone",
			clust_scarcity: 22,
			clust_num_ores: 7,
			clust_size: 3,
			y_max: -512,
			y_min: -1023,
		}];
	}
}
