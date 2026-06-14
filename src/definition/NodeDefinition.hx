package definition;

interface NodeDefinition extends ItemDefinition {}

@:luantiNode("infdev:dirt")
class Dirt implements NodeDefinition {
	public var testing: () -> Void = () -> {
		// trace("testing var");
	};
}
