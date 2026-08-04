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

		// Allow chat commands to have a constructor with no parameters optionally to do ridiculous things.
		final hasNew: Field = Lambda.find(fields, (f: Field) -> f.name == "new");
		if (hasNew != null) {
			switch (hasNew.kind) {
				case FFun(func):
					if (func.args.length > 0) {
						Context.error("Constructors in chat commands must have no parameters.", hasNew.pos);
					}

				default:
			}
		}

		if (!localClass.meta.has(":register")) {
			Context.error('Please register your chat command with @:register("my_command")', localClass.pos);
		}

		var registrationName;

		{
			var metaEntry = localClass.meta.extract(":register")[0];
			// trace(metaEntry);
			if (metaEntry == null) {
				Context.error("Something blew up.", localClass.pos);
			}
			var constantEnum = metaEntry.params[0].expr.getParameters()[0];
			switch (constantEnum) {
				case CString(s, _):
					registrationName = s;
				case _:
					try {
						registrationName = haxe.macro.ExprTools.getValue(metaEntry.params[0]);
					} catch (e:Dynamic) {
						Context.error("Could not parse @:register value as a string literal.", metaEntry.params[0].pos);
					}
			}
		}

		var wrapperClassName = localClass.name + "Wrapper";

		var localClassComplexType = Context.toComplexType(TInst(Context.getLocalClass(), []));

		var companionClassDefinition: TypeDefinition = {
			pack: localClass.pack, // Places it in the exact same package/folder path.
			name: wrapperClassName,
			pos: Context.currentPos(),
			kind: TDClass(null, null, false, true, false), // Final.
			fields: [
				// ? The preliminary components of a chat command.
				{
					name: "params",
					access: [AStatic],
					pos: Context.currentPos(),
					kind: FVar(macro : String, null)
				},
				{
					name: "description",
					access: [AStatic],
					pos: Context.currentPos(),
					kind: FVar(macro : String, null)
				},
				{
					name: "privs",
					access: [AStatic],
					pos: Context.currentPos(),
					kind: FVar(macro : src.engine.compilercode.LuaMap<String, Bool>, null)
				},
				// ? End preliminary components.
				{
					name: "instance",
					access: [AStatic],
					pos: Context.currentPos(),
					kind: FVar(localClassComplexType, null)
				},
				{
					name: "__init__",
					access: [AStatic],
					pos: Context.currentPos(),
					kind: FFun({
						args: [],
						ret: null,
						expr: macro {
							// ! Note: If nothing is defined in your class, this will error out.
							instance = Type.createInstance(Type.resolveClass($v{className}), []);

							// Hook the static wrapper into the instance components.
							// todo: this should be a function.
							params = instance.params;
							description = instance.description;
							privs = instance.privs;

							// untyped {
							// 	 print(dump(instance));
							// 	 print(dump($i{wrapperClassName}));
							// }

							untyped __lua__("core.register_chatcommand({0}, {1})", $v{registrationName}, $i{wrapperClassName});
						}
					})
				},

				// ? This is literally catching the statically typed haxe data and converting it to
				// ? a lua multireturn because chat commands are minimal performance intensive so
				// ? I'd rather have it easier to use while writing.
				{
					name: "func",
					access: [AStatic],
					pos: Context.currentPos(),
					meta: [],
					kind: FFun({
						args: [ // func(name: String, param: String): Void
							{
								name: "name",
								type: macro : String,
								opt: false,
								value: null
							},
							{
								name: "param",
								type: macro : String,
								opt: false,
								value: null
							},
						],
						ret: null,
						expr: macro {
							var outputData = instance.func(name, param);
							// trace(outputData);
							return untyped __lua__("{0}, {1}", outputData.success, outputData.output);
						}
					})
				}
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
