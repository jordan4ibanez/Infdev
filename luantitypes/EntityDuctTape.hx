package luantitypes;

// Note: This was heavily researched and assisted by AI because I have no idea
// what all the intricasies of this language are to facilitate how this functions.
// It also took a really long time because the docs are so weird and getting
// debug info in macro mode is not so good.
// This is basically injecting a patcher into on_activate, or creating a method
// for on_activate if it's missing, to inject the haxe object into the luanti object.
// This happens for all child classes that extend out of entity. Even great
// grand child classes.
#if macro
import haxe.macro.Context;
import haxe.macro.Expr;

class EntityDuctTape {
	public static function build(): Array<Field> {
		var fields = Context.getBuildFields();

		var localClass = Context.getLocalClass().get();

		// Fully qualified.
		var className = Context.getLocalClass().toString();

		if (className != "entity.LuaEntity") {
			final hasNew: Field = Lambda.find(fields, (f: Field) -> f.name == "new");
			if (hasNew != null) {
				Context.error("Error: Do not not use new(). Override onActivate().", hasNew.pos);
			}
		}

		// ? This converts a standard Haxe class into a Luanti compatible class.

		final onActivate: Field = Lambda.find(fields, (f: Field) -> f.name == "onActivate");

		if (onActivate != null) {
			// Inject code into their existing method
			switch (onActivate.kind) {
				case FFun(func):
					if (func.expr != null) {
						var injectExpr = macro {
							luantitypes.Macros.entityPatch();
							// trace("Auto-injected on_activate into " + $v{className});
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
					Context.error("on_activate is wrong?", onActivate.pos);
			}
		} else {
			var newFunction;

			var access = localClass.superClass == null ? [APublic] : [APublic, AOverride];

			if (localClass.superClass == null) {
				newFunction = macro function(staticData: String, dtimeS: Float) {
					luantitypes.Macros.entityPatch();
					// trace("Generated fallback on_activate for " + $v{className});
				};
			} else {
				newFunction = macro function(staticData: String, dtimeS: Float) {
					super.onActivate(staticData, dtimeS); // Super gets called first.
					luantitypes.Macros.entityPatch();
					// trace("Generated fallback on_activate for " + $v{className});
				};
			}
			switch (newFunction.expr) {
				case EFunction(_, func):
					fields.push({
						name: "onActivate",
						access: access,
						kind: FFun(func),
						pos: Context.currentPos()
					});
				default:
					Context.error("Something exploded in the entity duct tape patch.", Context.currentPos());
			}
		}

		return fields;
	}
}
#end // if macro
