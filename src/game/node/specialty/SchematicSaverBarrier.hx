package src.game.node.specialty;

import src.engine.definition.NodeDefinition;
import src.game.groups.NodeGroup;

@:register("infdev:schematic_saver_barrier")
final class SchematicSaverBarrier extends NodeDefinition {
	public function new() {
		super();

		this.description = "Schematic Saver Barrier";

		this.nodeGroups = [
			NodeGroupBedrock => BEDROCK
		];

		this.pointable = false;
		this.walkable = false;
		this.drawType = DrawTypeAirLike;
		this.paramtype1 = ParamType1Light;
		this.sunlightPropagates = true;
		this.lightSource = 14;
		this.inventoryImage = "default_cobble";
	}
}
