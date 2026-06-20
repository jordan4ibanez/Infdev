package engine.definition.graphics;

import haxe.extern.EitherType;

/**
 * Basically a tile definition but for items.
 */
class ItemImageDefinition {
	var name: String;
	var animation: TileAnimationDefinition;

	public function new(name: String, animation: TileAnimationDefinition) {
		this.name = name;
		this.animation = animation;
	}
}

typedef ItemImageDefinitionOrString = EitherType<ItemImageDefinition, String>;
