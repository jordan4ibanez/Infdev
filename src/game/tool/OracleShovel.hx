package src.game.tool;

import src.engine.definition.NodeDefinition.MAX_NODE_LEVEL;
import src.engine.definition.ToolDefinition;
import src.engine.definition.basic.ToolCapabilities;

@:register("infdev:oracle_shovel")
final class OracleShovel extends ToolDefinition {
	public function new() {
		super();

		this.description = "Oracle Shovel";

		this.inventoryImage = "oracle_shovel.png";
		this.wieldImage = "oracle_shovel.png";

		this.toolCapabilities = new ToolCapabilities()
			.setMaxDropLevel(0)
			.addGroupCap(NodeGroupDirt, new GroupCapabilities(0.1, 0.005, MAX_NODE_LEVEL, 1_000_000))
			.addGroupCap(NodeGroupSoil, new GroupCapabilities(0.1, 0.005, MAX_NODE_LEVEL, 1_000_000))
			.addGroupCap(NodeGroupSand, new GroupCapabilities(0.1, 0.005, MAX_NODE_LEVEL, 1_000_000))
			.addGroupCap(NodeGroupFarmLand, new GroupCapabilities(0.1, 0.005, MAX_NODE_LEVEL, 1_000_000));
	}
}
