package src.game.ore;

import src.engine.definition.OreDefinition;
import src.game.groups.NodeGroup;
import src.game.node.stone.StoneSound;

@:register("infdev:coal_ore")
final class CoalOre extends OreDefinition {
	public function new() {
		super();

		this.nodeGroups = [
			NodeGroupStone => 1
		];

		// Why is this called mineral and not ore?????
		this.tiles = ["default_stone.png^default_mineral_coal.png"];

		this.nodeSounds = StoneSound.get();

		// todo: make this an actual item
		this.drop = "infdev:coal";
	}
}
