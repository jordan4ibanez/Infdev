package src.game.node;

@:register("infdev:dirt")
final class Dirt extends NodeDefinition {
	public function new() {
		super();

		this.nodeGroups = [
			NodeGroupDirt => 1
		];

		tiles = ["default_dirt.png"];
	}
}
