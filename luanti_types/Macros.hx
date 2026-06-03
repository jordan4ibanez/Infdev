package luanti_types;

import haxe.macro.Context;
import haxe.macro.Expr;

class Macros {
	macro public static function getCompileTimeClassName(): Expr {
		var localClass = Context.getLocalClass();
		var name = (localClass != null) ? localClass.get().name : "Unknown";
		return macro $v{name};
	}
}
