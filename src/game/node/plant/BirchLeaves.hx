package src.game.node.plant;

import src.engine.definition.NodeDefinition;
import src.game.groups.NodeGroup;

@:register("infdev:birch_leaves")
final class BirchLeaves extends NodeDefinition {
	public function new() {
		super();

		this.description = "Birch Leaves";

		this.drawType = DrawTypeAllFacesOptional;

		this.tiles = ["default_aspen_leaves.png"];

		this.waving = WavingTypeLeaves;

		this.paramtype1 = ParamType1Light;

		this.isGroundContent = false;

		this.nodeGroups = [
			NodeGroupPlant => 1
		];

		this.nodeSounds = PlantSound.get();
	}
}
