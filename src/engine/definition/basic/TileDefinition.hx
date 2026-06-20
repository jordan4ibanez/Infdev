package engine.definition.basic;

import engine.definition.images.TileAnimationDefinition;

abstract class TileDefinition {
	var name: String;

	public function new(name: String) {
		this.name = name;
	}
}

class TileDefinitionAnimated extends TileDefinition {
	var animation: TileAnimationDefinition;

	public function new(name: String) {
		super(name);
	}

	public function setAnimation(animation: TileAnimationDefinition): TileDefinitionAnimated {
		this.animation = animation;
		return this;
	}
}

enum abstract TileDefinitionAlignStyle(String) to String {
	var TileDefinitionAlignStyleNode = "node";
	var TileDefinitionAlignStyleWorld = "world";
	var TileDefinitionAlignStyleUser = "user";
}

class TileDefinitionCustom extends TileDefinition {
	@:native("backface_culling")
	var backfaceCulling: Bool;

	@:native("align_style")
	var alignStyle: TileDefinitionAlignStyle;

	public function new(name: String) {
		super(name);
	}

	public function setBackfaceCulling(backfaceCulling: Bool): TileDefinitionCustom {
		this.backfaceCulling = backfaceCulling;
		return this;
	}
}
