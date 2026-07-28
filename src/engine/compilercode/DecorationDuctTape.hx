package src.engine.compilercode;

#if macro
import haxe.macro.Context;
import haxe.macro.Expr;

class DecorationDuctTape {
	public static function build(): Array<Field> {
		var fields = Context.getBuildFields();

		return fields;
	}
}
#end // if macro
