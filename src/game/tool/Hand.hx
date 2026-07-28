package src.game.tool;

import src.engine.definition.NodeDefinition;
import src.engine.definition.ToolDefinition;
import src.engine.definition.basic.ToolCapabilities;
import src.engine.vector.Vec3;
import src.game.groups.NodeGroup;

@:noCompletion
@:register("infdev:virtual_hand_3d")
final class VirtualHand extends NodeDefinition {
	public function new() {
		super();

		this.drawType = DrawTypeMesh;
		this.mesh = "hand.glb";
		this.tiles = ["character.png"];
	}
}

@:override("")
final class Hand extends ToolDefinition {
	public function new() {
		super();
		wieldScale = new Vec3(1, 1, 1);
		this.itemColor = "white";
		this.toolCapabilities = new ToolCapabilities()
			.addGroupCap(NodeGroupHandDiggable, new GroupCapabilities(2.0, 10.0, 0, 0, [BEDROCK => Math.POSITIVE_INFINITY]))
			.addGroupCap(NodeGroupStone, new GroupCapabilities(10.0, 20.0, 0, 0))
			.addGroupCap(NodeGroupDirt, new GroupCapabilities(5.0, 10.0, 0, 0))
			.addGroupCap(NodeGroupSoil, new GroupCapabilities(5.0, 10.0, 0, 0))
			.addGroupCap(NodeGroupSand, new GroupCapabilities(5.0, 10.0, 0, 0))
			.addGroupCap(NodeGroupPlant, new GroupCapabilities(2.0, 3.0, 0, 0));
	}
}
