package luanti_types;

import haxe.macro.Context;
import haxe.macro.Expr;

class Macros {
	macro public static function getCompileTimeClassName(): Expr {
		var localClass = Context.getLocalClass();
		var name = (localClass != null) ? localClass.get().name : "Unknown";
		return macro $v{name};
	}

	macro public static function getCompileTimeClass(): haxe.macro.Expr {
		var localClass = haxe.macro.Context.getLocalClass();
		if (localClass != null) {
			var classData = localClass.get();
			return {expr: EConst(CIdent(classData.name)), pos: haxe.macro.Context.currentPos()};
		}
		return macro null;
	}
}
