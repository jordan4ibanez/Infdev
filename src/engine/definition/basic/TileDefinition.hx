package src.engine.definition.basic;

import haxe.extern.EitherType;
import src.engine.definition.graphics.ColorSpec;
import src.engine.definition.graphics.TileAnimationDefinition;

enum abstract TileDefinitionAlignStyle(String) to String {
	var TileDefinitionAlignStyleNode = "node";
	var TileDefinitionAlignStyleWorld = "world";
	var TileDefinitionAlignStyleUser = "user";
}

typedef TileDefinition = {
	var name: String;

	@:optional
	var tileable_vertical: Bool;

	@:optional
	var tileable_horizontal: Bool;

	@:optional
	var backface_culling: Bool;

	@:optional
	var animation: TileAnimationDefinition;

	@:optional
	var align_style: TileDefinitionAlignStyle;

	@:optional
	var scale: Int;

	@:optional
	var color: ColorSpec;
	// public function new(name: String) {
	// 	this.name = name;
	// }
	// public function setTileableVertical(setting: Bool): TileDefinition {
	// 	this.tileable_vertical = setting;
	// 	return this;
	// }
	// public function setTileableHorizontal(setting: Bool): TileDefinition {
	// 	this.tileable_horizontal = setting;
	// 	return this;
	// }
	// public function setBackfaceCulling(backfaceCulling: Bool): TileDefinition {
	// 	this.backface_culling = backfaceCulling;
	// 	return this;
	// }
	// public function setAnimation(animation: TileAnimationDefinition): TileDefinition {
	// 	this.animation = animation;
	// 	return this;
	// }
	// public function setAlignStyle(alignStyle: TileDefinitionAlignStyle): TileDefinition {
	// 	this.align_style = alignStyle;
	// 	return this;
	// }
	// public function setScale(scale: Int): TileDefinition {
	// 	this.scale = scale;
	// 	return this;
	// }
	// public function setColor(color: ColorSpec): TileDefinition {
	// 	this.color = color;
	// 	return this;
	// }
}

typedef TileDefinitionOrString = EitherType<TileDefinition, String>;
