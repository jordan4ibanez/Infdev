package definition;

/**
 * When you extend this class, you get a specialty static class which only uses
 * OOP for auto complete. Everything else custom needs to be static. This is enforced.
 * 
 * ItemDefinition is the root of all other definitions. (nodes, craftitem, tool)
 */
@:build(luantitypes.ItemDefinitionDuctTape.build())
@:autoBuild(luantitypes.ItemDefinitionDuctTape.build())
interface ItemDefinition {
	@:native("test1234")
	public var testing: () -> Void;
}
