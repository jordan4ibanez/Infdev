package luanti_types;

#if macro
import haxe.macro.Context;
import haxe.macro.Expr;

class EntityDuctTape {
	public static function build(): Array<Field> {
		var fields = Context.getBuildFields();

		var localClass = Context.getLocalClass().get();
		var className = localClass.name;

		final onActivate: Field = Lambda.find(fields, (f: Field) -> f.name == "on_activate");

		if (onActivate != null) {
			// Inject code into their existing method
			switch (onActivate.kind) {
				case FFun(func):
					if (func.expr != null) {
						var injectExpr = macro {
							trace("Auto-injected into " + $v{className});
						};

						switch (func.expr.expr) {
							case EBlock(exprs): exprs.unshift(injectExpr);

							default: func.expr = macro {
									$injectExpr;
									${func.expr};
								};
						}
					}
				default:
			}
		}

		return fields;
	}
}
#end // if macro
