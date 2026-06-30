package src.engine.definition.basic;

import haxe.extern.EitherType;
import src.engine.definition.graphics.ColorSpec;
import src.engine.definition.graphics.TileAnimationDefinition;

// todo: make this one class!

enum abstract TileDefinitionAlignStyle(String) to String {
	var TileDefinitionAlignStyleNode = "node";
	var TileDefinitionAlignStyleWorld = "world";
	var TileDefinitionAlignStyleUser = "user";
}

class TileDefinition {
	var name: String;

	@:native("tileable_vertical")
	var tileableVertical: Bool;

	@:native("tileable_horizontal")
	var tileableHorizontal: Bool;

	@:native("backface_culling")
	var backfaceCulling: Bool;

	var animation: TileAnimationDefinition;

	@:native("align_style")
	var alignStyle: TileDefinitionAlignStyle;

	var scale: Int;

	var color: ColorSpec;

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

	public function setBackfaceCulling(backfaceCulling: Bool): TileDefinition {
		this.backfaceCulling = backfaceCulling;
		return this;
	}

	public function setAnimation(animation: TileAnimationDefinition): TileDefinition {
		this.animation = animation;
		return this;
	}

	public function setAlignStyle(alignStyle: TileDefinitionAlignStyle): TileDefinition {
		this.alignStyle = alignStyle;
		return this;
	}

	public function setScale(scale: Int): TileDefinition {
		this.scale = scale;
		return this;
	}

	public function setColor(color: ColorSpec): TileDefinition {
		this.color = color;
		return this;
	}
}

typedef TileDefinitionOrString = EitherType<TileDefinition, String>;
