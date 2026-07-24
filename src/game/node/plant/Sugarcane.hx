package src.game.node.plant;

import src.engine.definition.NodeDefinition;
import src.engine.definition.basic.NodeBox;
import src.game.groups.NodeGroup;

@:register("infdev:sugarcane")
final class Sugarcane extends NodeDefinition {
	public function new() {
		super();

		this.description = "Sugarcane";

		this.tiles = [
			"default_papyrus.png"
		];

		this.drawType = DrawTypePlantLike;

		this.paramtype1 = ParamType1Light;

		this.sunlightPropagates = true;

		this.walkable = false;

		this.selectionBox = new NodeBoxFixed()
			.addBox(-6 / 16, -0.5, -6 / 16, 6 / 16, 0.5, 6 / 16);

		this.nodeGroups = [
			NodeGroupPlant => 1,
			NodeGroupAttachedNode => AttachedNodeSettingAlwaysToBelow,
		];

		this.nodeSounds = PlantSound.get();
	}
}
