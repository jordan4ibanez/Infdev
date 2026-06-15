package definition;

import definition.images.ItemImageDefinition;

/**
 * When you extend this class, you get a specialty static class which only uses
 * OOP for auto complete. Everything else custom needs to be static. This is enforced.
 * 
 * ItemDefinition is the root of all other definitions. (nodes, craftitem, tool)
 */
@:build(luantitypes.ItemDefinitionDuctTape.build())
@:autoBuild(luantitypes.ItemDefinitionDuctTape.build())
interface ItemDefinition {
	public var description: String;

	@:native("short_description")
	public var shortDescription: String;

	public var groups: Dynamic<Int>;

	@:native("wield_image")
	public var wieldImage: ItemImageDefinitionOrString;

	public var testing: () -> Void;
}
