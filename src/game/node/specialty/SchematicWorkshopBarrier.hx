package src.game.node.specialty;

import src.engine.definition.NodeDefinition;
import src.game.groups.NodeGroup;

@:register("infdev:schematic_workshop_barrier")
final class SchematicWorkshopBarrier extends NodeDefinition {
	public function new() {
		super();

		this.description = "Schematic Workshop Barrier";

		this.nodeGroups = [
			NodeGroupHandDiggable => BEDROCK
		];

		this.drawType = DrawTypeAirLike;
		this.pointable = false;
		this.walkable = false;
		this.paramtype1 = ParamType1Light;
		this.sunlightPropagates = true;
		this.lightSource = 14;
		this.inventoryImage = "default_cobble";
	}
}
