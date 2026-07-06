package src.game.tool;

import src.engine.definition.ToolCapabilities;
import src.engine.definition.ToolDefinition;
import src.engine.vector.Vec3;
import src.game.groups.NodeGroup;

@:override("")
final class Hand extends ToolDefinition {
	public function new() {
		super();
		wieldScale = new Vec3(1, 1, 1);
		this.itemColor = "white";
		this.toolCapabilities = new ToolCapabilities()
			.setFullPunchInterval(1.0)
			.addGroupCap(NodeGroupHandDiggable, new GroupCapabilities()
				.setTimesFromMap([
					1 => 1.0,
					2 => 2.0,
					3 => 3.0,
					BEDROCK => Math.POSITIVE_INFINITY
				])
				.setMaxLevel(0)
				.setUses(0));
	}
}
