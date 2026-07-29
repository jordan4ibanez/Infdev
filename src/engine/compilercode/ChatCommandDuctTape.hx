package src.engine.compilercode;

#if macro
import haxe.macro.Context;
import haxe.macro.Expr;

class ChatCommandDuctTape {
	public static function build(): Array<Field> {
		var fields = Context.getBuildFields();

		var localClass = Context.getLocalClass().get();

		// Do not bother scanning root interfaces.
		for (meta in localClass.meta.get()) {
			if (meta.name == ":decorationRoot") {
				return fields;
			}
		}

		// Fully qualified.
		var className = Context.getLocalClass().toString();

		// Require a class to be final.
		if (!localClass.isFinal) {
			Context.error("Class must be final.", localClass.pos);
		}

		// Do not allow chat commands to be constructed.
		// It's a pure data class with no interaction.
		final hasNew: Field = Lambda.find(fields, (f: Field) -> f.name == "new");
		if (hasNew != null) {
			Context.error("Do not use a constructor in chat commands. It's a data class.", localClass.pos);
		}

		return fields;
	}
}
#end // if macro
