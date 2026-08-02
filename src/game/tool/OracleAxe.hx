package src.game.tool;

import src.engine.definition.NodeDefinition.MAX_NODE_LEVEL;
import src.engine.definition.ToolDefinition;
import src.engine.definition.basic.ToolCapabilities;

@:register("infdev:oracle_axe")
final class OracleAxe extends ToolDefinition {
	public function new() {
		super();

		this.description = "Oracle Axe";

		this.inventoryImage = "oracle_axe.png";
		this.wieldImage = "oracle_axe.png";

		this.toolCapabilities = new ToolCapabilities()
			.setMaxDropLevel(0)
			.addGroupCap(NodeGroupWood, new GroupCapabilities(0.1, 0.005, MAX_NODE_LEVEL, 1_000_000))
			.addGroupCap(NodeGroupPlanks, new GroupCapabilities(0.1, 0.005, MAX_NODE_LEVEL, 1_000_000))
			.addGroupCap(NodeGroupTree, new GroupCapabilities(0.1, 0.005, MAX_NODE_LEVEL, 1_000_000));
	}
}
