package src.game.node.plant;

import src.engine.definition.NodeDefinition;
import src.game.groups.NodeGroup;

@:register("infdev:oak_leaves")
final class OakLeaves extends NodeDefinition {
	public function new() {
		super();

		this.description = "Oak Leaves";

		this.drawType = DrawTypeAllFacesOptional;

		this.tiles = ["default_leaves.png"];

		this.specialTiles = ["default_leaves_simple.png"];

		this.waving = WavingTypeLeaves;

		this.paramtype1 = ParamType1Light;

		this.isGroundContent = false;

		this.nodeGroups = [
			NodeGroupPlant => 1,
			NodeGroupLeaves => 1,
		];

		this.nodeSounds = PlantSound.get();
	}
}
