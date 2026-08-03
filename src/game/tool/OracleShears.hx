package src.game.tool;

import src.engine.definition.NodeDefinition.MAX_NODE_LEVEL;
import src.engine.definition.ToolDefinition;
import src.engine.definition.basic.ToolCapabilities;

@:register("infdev:oracle_shears")
final class OracleShears extends ToolDefinition {
	public function new() {
		super();

		this.description = "Oracle Shears";

		this.inventoryImage = "infdev_oracle_shears.png";
		this.wieldImage = "infdev_oracle_shears.png";

		this.toolCapabilities = new ToolCapabilities()
			.setMaxDropLevel(0)
			.addGroupCap(NodeGroupPlant, new GroupCapabilities(0.1, 0.005, MAX_NODE_LEVEL, 1_000_000))
			.addGroupCap(NodeGroupLeaves, new GroupCapabilities(0.1, 0.005, MAX_NODE_LEVEL, 1_000_000));
	}
}
