package luanti_types;

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

	// This one is interesting.
	public static macro function entityPatch(): haxe.macro.Expr {
		return macro {
			// Instance components.
			final instance = Type.createInstance(Macros.getCompileTimeClass(), []);
			for (field in Reflect.fields(instance)) {
				untyped this[field] = Reflect.field(instance, field);
			}
		}
	}
}
