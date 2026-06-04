package luanti_types;

// Note: This was heavily researched and assisted by AI because I have no idea
// what all the intricasies of this language are to facilitate how this functions.
// It also took a really long time because the docs are so weird and getting
// debug info in macro mode is not so good.
// This is basically injecting a patcher into on_activated, or creating a method
// for on_activated if it's missing, to inject the haxe object into the luanti object.
// This happens for all child classes that extend out of entity. Even great
// grand child classes.
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
					throw "on_activate is wrong?";
			}
		} else {
			var newFunction;

			var access = localClass.superClass == null ? [APublic] : [APublic, AOverride];

			if (localClass.superClass == null) {
				newFunction = macro function(staticData: String, dtimeS: Float) {
					trace("Generated fallback on_activate for " + $v{className});
				};

				switch (newFunction.expr) {
					case EFunction(_, func):
						fields.push({
							name: "on_activate",
							access: [APublic],
							kind: FFun(func),
							pos: Context.currentPos()
						});
					default:
				}
			} else {
				newFunction = macro function(staticData: String, dtimeS: Float) {
					trace("Generated fallback on_activate for " + $v{className});
					super.on_activate(staticData, dtimeS); // Safely call Entity's on_activate
				};

				switch (newFunction.expr) {
					case EFunction(_, func):
						fields.push({
							name: "on_activate",
							access: [APublic, AOverride], // Mark as an override
							kind: FFun(func),
							pos: Context.currentPos()
						});
					default:
				}
			}
		}

		return fields;
	}
}
#end // if macro
