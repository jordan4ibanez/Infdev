package src.game.node.stone;

import src.engine.definition.NodeDefinition;
import src.game.groups.NodeGroup;

@:register("infdev:fireclay_brick_block")
final class FireclayBrickBlock extends NodeDefinition {
	public function new() {
		super();

		this.nodeGroups = [
			NodeGroupStone => 1
		];

		this.description = "Fireclay Brick Block";

		this.nodeSounds = StoneSound.get();

		this.tiles = [
			"default_brick.png^[transformFX^[colorize:#988558:200",
			"default_brick.png^[colorize:#988558:200",
		];

		this.isGroundContent = false;

		this.recipesShaped = [
			{
				recipe: [
					["infdev:fireclay_brick", "infdev:fireclay_brick"],
					["infdev:fireclay_brick", "infdev:fireclay_brick"],
				]
			}
		];
	}
}
