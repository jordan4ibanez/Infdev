package src.game.node.dirt;

import src.engine.definition.NodeDefinition;
import src.engine.definition.basic.NodeDropTable;
import src.game.groups.NodeGroup;

@:register("infdev:clay_block")
final class ClayBlock extends NodeDefinition {
	public function new() {
		super();

		this.description = "Clay Block";

		this.nodeGroups = [
			NodeGroupSoil => 1,
		];

		this.nodeSounds = DirtSound.get();

		this.tiles = ["default_clay.png"];

		this.drop = new NodeDropTable()
			.addDrop(new NodeDrop()
				.addItems("infdev:clay", "infdev:clay", "infdev:clay"))
			.addDrop(new NodeDrop()
				.addItems("infdev:clay")
				.setRarity(5))
			.addDrop(new NodeDrop()
				.addItems("infdev:clay")
				.setRarity(100));
	}
}
