package src.game.node.utility;

import src.engine.definition.NodeDefinition;
import src.game.groups.NodeGroup;
import src.game.node.stone.StoneSound;

// todo: some kind of static helper class to mix them together as one unit :)

@:register("infdev:furnace_off")
final class FurnaceOff extends NodeDefinition {
	public function new() {
		super();

		this.description = "Furnace";

		this.nodeGroups = [
			NodeGroupStone => 2,
			NodeGroupCobblestone => 2,
		];

		this.nodeSounds = StoneSound.get();

		this.tiles = ["default_cobble.png"];

		this.paramtype2 = ParamType2FourDir;

		final cobble = NodeGroupCobblestone.groupify();

		this.recipesShaped = [{
			recipe: [
				[cobble, cobble, cobble,],
				[cobble, "", cobble,],
				[cobble, cobble, cobble,],
			]
		}];
	}
}

@:register("infdev:furnace_on")
final class FurnaceOn extends NodeDefinition {
	public function new() {
		super();

		this.description = "Furnace";

		this.nodeGroups = [
			NodeGroupStone => 2,
			NodeGroupCobblestone => 2,
		];

		this.paramtype2 = ParamType2FourDir;

		this.nodeSounds = StoneSound.get();

		this.tiles = ["default_cobble.png"];
	}
}
