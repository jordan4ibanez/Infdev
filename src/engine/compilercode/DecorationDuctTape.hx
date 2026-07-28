package src.engine.compilercode;

#if macro
import haxe.macro.Context;
import haxe.macro.Expr;

class DecorationDuctTape {
	public static function build(): Array<Field> {
		var fields = Context.getBuildFields();

		// Do not bother scanning root interfaces.
		for (meta in localClass.meta.get()) {
			if (meta.name == ":decorationRoot") {
				return fields;
			}
		}

		var localClass = Context.getLocalClass().get();

		// Fully qualified.
		var className = Context.getLocalClass().toString();

		trace(className);

		return fields;
	}
}
#end // if macro
