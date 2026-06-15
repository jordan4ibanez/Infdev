package definition;

import definition.TileAnimationDefinition.TileAnimationDefinitionSheet2d;
import haxe.extern.EitherType;
import definition.ItemImageDefinition;

interface NodeDefinition extends ItemDefinition {}

@:luantiNode("infdev:dirt")
final class Dirt implements NodeDefinition {
	public var description: String;
	public var shortDescription: String;
	public var groups: Dynamic<Int>;
	public var wieldImage: EitherType<ItemImageDefinition, String> = new ItemImageDefinition("image.png", new TileAnimationDefinitionSheet2d(12, 12, 10.0));

	public var testing: () -> Void;
}
