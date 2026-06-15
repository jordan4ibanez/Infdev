package definition;

interface NodeDefinition extends ItemDefinition {}

@:luantiNode("infdev:dirt")
class Dirt implements ItemDefinition {
	public var description: String;

	public static var blah: Int = 5;

	public var testing: () -> Void = () -> {
		this.description = "hi";
	};
}
