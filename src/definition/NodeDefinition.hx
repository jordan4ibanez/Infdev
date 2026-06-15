package definition;

interface NodeDefinition extends ItemDefinition {}

@:luantiNode("infdev:dirt")
class Dirt implements ItemDefinition {
	public var description: String = "hi";

	public var shortDescription: String = "test";

	public var testing: () -> Void = () -> {};
}
