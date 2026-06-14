package node;

/**
 * When you extend this class, you get a specialty static class which only uses
 * OOP for auto complete.
 */
@:autoBuild(luantitypes.NodeDuctTape.build())
interface Node {
	@:native("test1234")
	public var testing: () -> Void;
}

@:luantiNode("infdev:dirt")
class Dirt implements Node {
	public var testing: () -> Void = () -> {};
}
