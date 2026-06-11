package luantitypes;

import haxe.macro.Context;
import haxe.macro.Expr;

class Macros {
	public static macro function getCompileTimeClassName(): Expr {
		var localClass = Context.getLocalClass();
		var name = (localClass != null) ? localClass.get().name : "Unknown";
		return macro $v{name};
	}

	public static macro function getCompileTimeClass(): haxe.macro.Expr {
		var localClass = haxe.macro.Context.getLocalClass();
		if (localClass != null) {
			var classData = localClass.get();
			return {expr: EConst(CIdent(classData.name)), pos: haxe.macro.Context.currentPos()};
		}
		return macro null;
	}

	/**
	 * Decorates your Luanti entity on_activate with code cloning from Haxe object.
	 * @return haxe.macro.Expr Code!
	 */
	public static macro function entityPatch(): haxe.macro.Expr {
		return macro {
			// Instance components.
			final instance = Type.createInstance(luantitypes.Macros.getCompileTimeClass(), []);
			// trace("decorating: " + luantitypes.Macros.getCompileTimeClassName());
			for (field in Reflect.fields(instance)) {
				// This is decorated by the engine. (And not protected by it)
				if (field == "object" || field == "name") {
					continue;
				}
				untyped this[field] = Reflect.field(instance, field);
			}
		}
	}
}
