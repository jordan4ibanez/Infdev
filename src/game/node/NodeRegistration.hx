package src.game.node;

import src.engine.definition.NodeDefinition;
import src.game.groups.NodeGroup;

@:register("infdev:dirt")
final class Dirt extends NodeDefinition {
	public function new() {
		super();
		this.nodeColor = "blue";

		this.nodeGroups = [
			NodeGroupDirt => 1
		];

		// Lua.print(Global.dump(this.itemGroups));
	}
}

@:register("infdev:stone")
final class Stone extends NodeDefinition {
	public function new() {
		super();
		this.nodeColor = "blue";
		this.nodeGroups = [
			NodeGroupStone => 1
		];
	}
}

@:register("infdev:water_source")
final class WaterSource extends NodeDefinition {
	public function new() {
		super();

		// trace("I am aqua");
	}
}
