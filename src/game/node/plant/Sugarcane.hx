package src.game.node.plant;

import src.engine.Core;
import src.engine.NodeTable;
import src.engine.definition.NodeDefinition;
import src.engine.definition.basic.NodeBox;
import src.engine.vector.Vec3;
import src.game.groups.NodeGroup;

@:register("infdev:sugarcane")
final class Sugarcane extends NodeDefinition {
	public function new() {
		super();

		this.description = "Sugarcane";

		this.tiles = [
			"default_papyrus.png"
		];

		this.nodePlacementPrediction = "";

		this.drawType = DrawTypePlantLike;

		this.paramtype1 = ParamType1Light;

		this.sunlightPropagates = true;

		this.walkable = false;

		this.selectionBox = new NodeBoxFixed()
			.addBox(-6 / 16, -0.5, -6 / 16, 6 / 16, 0.5, 6 / 16);

		this.nodeGroups = [
			NodeGroupPlant => 1,
		];

		this.nodeSounds = PlantSound.get();
	}

	override function afterDestruct(pos: Vec3, oldNode: NodeTable) {
		super.afterDestruct(pos, oldNode);

		pos.y += 1;
		var nodeAbove = Core.getNode(pos);

		if (nodeAbove.name == "infdev:sugarcane") {
			Core.digNode(pos);
		}
	}
}
