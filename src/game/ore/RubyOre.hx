package src.game.ore;

import src.engine.definition.OreDefinition;
import src.game.groups.NodeGroup;
import src.game.node.stone.StoneSound;

@:register("infdev:ruby_ore")
final class RubyOre extends OreDefinition {
	public function new() {
		super();

		this.nodeGroups = [
			NodeGroupStone => 4
		];

		this.tiles = ["default_stone.png^(default_mineral_diamond.png^[colorize:red:190)"];

		this.nodeSounds = StoneSound.get();

		// todo: make this an actual item
		this.drop = "infdev:ruby";

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
