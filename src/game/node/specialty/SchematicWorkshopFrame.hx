package src.game.node.specialty;

import src.engine.definition.NodeDefinition;
import src.game.groups.NodeGroup;

@:register("infdev:schematic_workshop_frame")
final class SchematicWorkshopFrame extends NodeDefinition {
	public function new() {
		super();

		this.description = "Schematic Workshop Frame";

		this.nodeGroups = [
			NodeGroupHandDiggable => BEDROCK
		];
		this.lightSource = 14;
		this.inventoryImage = "default_cobble";
	}
}
