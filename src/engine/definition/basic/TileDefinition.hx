package engine.definition.basic;

import engine.definition.images.TileAnimationDefinition;

abstract class TileDefinition {
	var name: String;

	public function new(name: String) {
		this.name = name;
	}
}

class TileDefinitionAnimated extends TileDefinition {
	var animation: TileAnimationDefinition

	public function new(name: String) {
		super(name);
	}
}
