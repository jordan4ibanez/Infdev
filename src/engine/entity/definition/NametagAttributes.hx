package src.engine.entity.definition;

import haxe.extern.EitherType;
import src.engine.definition.graphics.ColorSpec;

typedef NametagAttributes = {
	@:optional
	var text: String;
	@:optional
	var color: ColorSpec;
	@:optional
	var bgcolor: EitherType<ColorSpec, Bool>;
}
