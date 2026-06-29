package src.engine.definition.basic;

import haxe.extern.EitherType;
import src.engine.definition.graphics.ColorSpec;
import src.engine.definition.graphics.TileAnimationDefinition;

class TileDefinition {
	var name: String;

	@:native("tileable_vertical")
	var tileableVertical: Bool;

	@:native("tileable_horizontal")
	var tileableHorizontal: Bool;

	public function new(name: String) {
		this.name = name;
	}

	public function setTileableVertical(setting: Bool): TileDefinition {
		this.tileableVertical = setting;
		return this;
	}

	public function setTileableHorizontal(setting: Bool): TileDefinition {
		this.tileableHorizontal = setting;
		return this;
	}
}

typedef TileDefinitionOrString = EitherType<TileDefinition, String>;

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

	var scale: Int;

	public function new(name: String) {
		super(name);
	}

	public function setBackfaceCulling(backfaceCulling: Bool): TileDefinitionCustom {
		this.backfaceCulling = backfaceCulling;
		return this;
	}

	public function setAlignStyle(alignStyle: TileDefinitionAlignStyle): TileDefinitionCustom {
		this.alignStyle = alignStyle;
		return this;
	}

	public function setScale(scale: Int): TileDefinitionCustom {
		this.scale = scale;
		return this;
	}
}

class TileDefinitionColorSpec extends TileDefinition {
	var color: ColorSpec;

	public function new(name: String) {
		super(name);
	}

	public function setColor(color: ColorSpec): TileDefinitionColorSpec {
		this.color = color;
		return this;
	}
}
