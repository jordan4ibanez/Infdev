package src.engine.compilercode;

#if macro
import haxe.macro.Context;
import haxe.macro.Expr;

class DecorationDuctTape {
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

		// I could probably make this dump a bunch of instances into a single static class.
		// But, this is easier.

		var wrapperClassName = localClass.name + "Wrapper";

		var localClassComplexType = Context.toComplexType(TInst(Context.getLocalClass(), []));

		var companionClassDefinition: TypeDefinition = {
			pack: localClass.pack, // Places it in the exact same package/folder path.
			name: wrapperClassName,
			pos: Context.currentPos(),
			kind: TDClass(null, null, false, true, false), // Final.
			fields: [
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
							trace("Test static class");
						}
					})
				},
			],
			meta: []
		}

		trace(className);

		return fields;
	}
}
#end // if macro
