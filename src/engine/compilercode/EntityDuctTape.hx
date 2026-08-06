package src.engine.compilercode;

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
	static function methodResolution() {}

	public static function build(): Array<Field> {
		var fields = Context.getBuildFields();

		var localClass = Context.getLocalClass().get();

		// Fully qualified.
		var className = Context.getLocalClass().toString();

		if (className != "src.engine.entity.LuaEntity") {
			final hasNew: Field = Lambda.find(fields, (f: Field) -> f.name == "new");
			if (hasNew != null) {
				Context.error("Error: Do not not use new(). Override onActivate().", hasNew.pos);
			}
		}

		// ? This allows you to register an entity at the top of your class with @:register("")
		// ? This also allows you to define root nodes for a small performance boost with @:entityRoot
		var isEntityRoot: Bool = false;

		for (meta in localClass.meta.get()) {
			// trace(meta.name);

			// An entity root stops the warning to perform the entity patch because other classes extend it.
			if (meta.name == ":entityRoot") {
				isEntityRoot = true;
			}

			// It turns out that core.override_entity doesn't exist. I was going to put a todo here.
			if (meta.name == ":register") {
				if (isEntityRoot) {
					Context.error("Do not register an entity root.", localClass.pos);
				}

				final firstParameter = meta.params[0];
				if (firstParameter == null) {
					Context.error("luantiClass requires a string parameter", meta.pos);
				}

				switch (firstParameter.expr) {
					case EConst(CString((value))):
						{
							if (value.length == 0) {
								Context.error("luantiClass does not accept a blank string", meta.pos);
							}

							// And if it got this far then it's up to them to ensure it's a good name.

							final init: Field = Lambda.find(fields, (f: Field) -> f.name == "__init__");

							if (init != null) {
								// Inject code into their existing method
								switch (init.kind) {
									case FFun(func):
										if (func.expr != null) {
											var injectExpr = macro {
												src.engine.entity.LuaEntity.registerEntity($v{value}, $i{localClass.name});
												// trace("Auto-injected registration __init__ into " + $v{className});
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
										Context.error("__init__ is wrong?", init.pos);
								}
							} else {
								// trace(localClass.name);
								var newFunction = macro function() {
									src.engine.entity.LuaEntity.registerEntity($v{value}, $i{localClass.name});
									// trace("Auto-created registration __init__ into " + $v{className});
								};

								switch (newFunction.expr) {
									case EFunction(_, func):
										fields.push({
											name: "__init__",
											access: [AStatic],
											kind: FFun(func),
											pos: Context.currentPos()
										});
									default:
										Context.error("Something exploded in the entity duct tape patch __init__.", Context.currentPos());
								}
							}
						}

					default:
						Context.error("luantiClass requires a string parameter", meta.pos);
				}
			}
		}

		// ? This converts a standard Haxe class into a Luanti compatible class.

		// todo: this is absolutely horrible and breaks autocompletion

		final onActivate: Field = Lambda.find(fields, (f: Field) -> f.name == "onActivate");

		if (onActivate == null) {
			Context.warning('Class ${className} requires an onActivate method for Luanti compatibility. Your entity will not function properly without it.', localClass.pos);
		} else {
			if (className != "src.engine.entity.LuaEntity") {
				switch (onActivate.kind) {
					case FFun(func):
						var hasEntityPatch = false;
						var hasSuperCall = false;
						if (func.expr != null) {
							switch (func.expr.expr) {
								case EBlock(exprs):
									if (exprs.length > 0) {
										var firstLineStr = haxe.macro.ExprTools.toString(exprs[0]);
										if (firstLineStr == "src.engine.compilercode.Macros.entityPatch()"
											|| firstLineStr == "Macros.entityPatch()") {
											hasEntityPatch = true;
										}
									}

									if (exprs.length > 1) {
										switch (exprs[1].expr) {
											case ECall({expr: EField({expr: EConst(CIdent("super"))}, "onActivate")}, _):
												hasSuperCall = true;
											case _:
										}
									}
								case _:
									var singleLineStr = haxe.macro.ExprTools.toString(func.expr);
									if (singleLineStr == "src.engine.compilercode.Macros.entityPatch()"
										|| singleLineStr == "Macros.entityPatch()") {
										hasEntityPatch = true;
									}
							}
						}

						if (!hasEntityPatch) {
							Context.warning('Class ${className} must call src.engine.compilercode.Macros.entityPatch(); as the first line in onActivate().', onActivate.pos);
						} else if (!hasSuperCall) {
							Context.warning('Class ${className} must call super.onActivate(staticData, dtimeS) directly after Macros.entityPatch().', onActivate.pos);
						}
					case _:
						// The field is not a function. This should never happen.
				}
			}
		}

		// if (onActivate != null) {
		// 	// Inject code into their existing method
		// 	switch (onActivate.kind) {
		// 		case FFun(func):
		// 			if (func.expr != null) {
		// 				var injectExpr = macro {
		// 					src.engine.compilercode.Macros.entityPatch();
		// 					// trace("Auto-injected on_activate into " + $v{className});
		// 				};

		// 				switch (func.expr.expr) {
		// 					case EBlock(exprs): exprs.unshift(injectExpr);

		// 					default: func.expr = macro {
		// 							$injectExpr;
		// 							${func.expr};
		// 						};
		// 				}
		// 			}
		// 		default:
		// 			Context.error("on_activate is wrong?", onActivate.pos);
		// 	}
		// } else {
		// 	var newFunction;

		// 	var access = localClass.superClass == null ? [APublic] : [APublic, AOverride];

		// 	if (localClass.superClass == null) {
		// 		newFunction = macro function(staticData: String, dtimeS: Float) {
		// 			src.engine.compilercode.engine.Macros.entityPatch();
		// 			// trace("Generated fallback on_activate for " + $v{className});
		// 		};
		// 	} else {
		// 		newFunction = macro function(staticData: String, dtimeS: Float) {
		// 			super.onActivate(staticData, dtimeS); // Super gets called first.
		// 			src.engine.compilercode.Macros.entityPatch();
		// 			// trace("Generated fallback on_activate for " + $v{className});
		// 		};
		// 	}
		// 	switch (newFunction.expr) {
		// 		case EFunction(_, func):
		// 			fields.push({
		// 				name: "onActivate",
		// 				access: access,
		// 				kind: FFun(func),
		// 				pos: Context.currentPos()
		// 			});
		// 		default:
		// 			Context.error("Something exploded in the entity duct tape patch.", Context.currentPos());
		// 	}
		// }

		return fields;
	}
}
#end // if macro
