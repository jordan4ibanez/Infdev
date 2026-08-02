package src.game.node.specialty;

import src.engine.definition.NodeDefinition;
import src.game.groups.NodeGroup;

@:register("infdev:schematic_saver_frame")
final class SchematicSaverFrame extends NodeDefinition {
	public function new() {
		super();

		this.description = "Schematic Saver Frame";

		this.nodeGroups = [
			NodeGroupBedrock => BEDROCK
		];
		this.lightSource = 14;
		this.inventoryImage = "default_cobble";
	}
}
