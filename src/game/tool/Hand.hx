package src.game.tool;

import src.engine.definition.NodeDefinition;
import src.engine.definition.ToolCapabilities;
import src.engine.definition.ToolDefinition;
import src.engine.vector.Vec3;
import src.game.groups.NodeGroup;

@:noCompletion
@:register("infdev:virtual_hand_3d")
final class VirtualHand extends NodeDefinition {
	public function new() {
		super();

		this.drawType = DrawTypeMesh;
		// todo: this needs to be remade
		this.mesh = "mcl_meshhand.b3d";
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
			.setFullPunchInterval(1.0)
			.addGroupCap(NodeGroupHandDiggable, new GroupCapabilities(2.0, 10.0, 0, 0, [BEDROCK => Math.POSITIVE_INFINITY]))
			.addGroupCap(NodeGroupStone, new GroupCapabilities(10.0, 20.0, 0, 0))
			.addGroupCap(NodeGroupDirt, new GroupCapabilities(5.0, 10.0, 0, 0))
			.addGroupCap(NodeGroupSand, new GroupCapabilities(5.0, 10.0, 0, 0));
	}
}
