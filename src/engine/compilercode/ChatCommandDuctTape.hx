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

		var wrapperClassName = localClass.name + "Wrapper";

		var localClassComplexType = Context.toComplexType(TInst(Context.getLocalClass(), []));

		var companionClassDefinition: TypeDefinition = {
			pack: localClass.pack, // Places it in the exact same package/folder path.
			name: wrapperClassName,
			pos: Context.currentPos(),
			kind: TDClass(null, null, false, true, false), // Final.
			fields: [
				{
					name: "__init__",
					access: [AStatic],
					pos: Context.currentPos(),
					kind: FFun({
						args: [],
						ret: null,
						expr: macro {
							// ! Note: If nothing is defined in your class, this will error out.
							var instance = Type.createInstance(Type.resolveClass($v{className}), []);

							untyped {
								// Remove haxe metadata.
								// instance.__fields__ = null;
								print(dump(instance));
							}
							// untyped __lua__("core.register_decoration({0})", instance);
						}
					})
				},
			],
			meta: []
		}

		// ? Finally inject the class directly into the compiler compilation pool.

		try {
			Context.defineType(companionClassDefinition);
			// ? This is important for debugging.
			// trace('DuctTape: Successfully generated companion class: ' + localClass.pack.join(".") + "." + wrapperClassName);
		} catch (e:Dynamic) {
			// Prevent duplicate definition errors if the macro triggers multiple times.
		}

		return fields;
	}
}
#end // if macro
