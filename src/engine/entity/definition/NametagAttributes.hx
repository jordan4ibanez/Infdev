package src.engine.entity.definition;

import haxe.extern.EitherType;
import src.engine.definition.graphics.ColorSpec;

typedef NametagAttributes = {
	var text: String;
	var color: ColorSpec;
	var bgcolor: EitherType<ColorSpec, Bool>;
}
