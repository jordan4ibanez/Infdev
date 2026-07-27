package src.game.node.stone;

import src.engine.definition.NodeDefinition;
import src.game.groups.NodeGroup;

@:register("infdev:brick_block")
final class BrickBlock extends NodeDefinition {
	public function new() {
		super();

		this.nodeGroups = [
			NodeGroupStone => 1
		];

		this.description = "Brick Block";

		this.nodeSounds = StoneSound.get();

		this.tiles = [
			"default_brick.png^[transformFX",
			"default_brick.png",
		];

		this.isGroundContent = false;

		this.recipesShaped = [
			{
				recipe: [
					["infdev:brick", "infdev:brick"],
					["infdev:brick", "infdev:brick"],
				]
			}
		];
	}
}
