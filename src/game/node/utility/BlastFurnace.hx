package src.game.node.utility;

import src.engine.definition.NodeDefinition;
import src.game.groups.NodeGroup;
import src.game.node.stone.StoneSound;

// todo: some kind of static helper class to mix them together as one unit :)

@:register("infdev:blast_furnace_off")
final class BlastFurnaceOff extends NodeDefinition {
	public function new() {
		super();

		this.description = "Blast Furnace";

		this.nodeGroups = [
			NodeGroupStone => 2,
			NodeGroupCobblestone => 2,
		];

		this.nodeSounds = StoneSound.get();

		this.tiles = ["default_brick.png"];

		this.paramtype2 = ParamType2FourDir;

		this.recipesShaped = [{
			recipe: [
				["infdev:fireclay_brick", "infdev:fireclay_brick", "infdev:fireclay_brick"],
				["infdev:fireclay_brick", "infdev:iron_ingot", "infdev:fireclay_brick"],
				["infdev:fireclay_brick", "infdev:fireclay_brick", "infdev:fireclay_brick"],
			]
		}];
	}
}

@:register("infdev:blast_furnace_on")
final class BlastFurnaceOn extends NodeDefinition {
	public function new() {
		super();

		this.description = "Blast Furnace";

		this.nodeGroups = [
			NodeGroupStone => 2,
			NodeGroupCobblestone => 2,
		];

		this.paramtype2 = ParamType2FourDir;

		this.nodeSounds = StoneSound.get();

		this.tiles = ["default_brick.png"];
	}
}
