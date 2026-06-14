package luantitypes;

#if macro
import haxe.macro.Context;
import haxe.macro.Expr;

// AI also heavily guided this development cause this is a fucking mess.
// This is cramming OOP into lua style static everything while trying to make it
// not a horrific mess to use.
class ItemDefinitionDuctTape {
	public static function build(): Array<Field> {
		var fields = Context.getBuildFields();

		var localClass = Context.getLocalClass().get();

		// Fully qualified.
		var className = Context.getLocalClass().toString();

		final hasNew: Field = Lambda.find(fields, (f: Field) -> f.name == "new");
		if (hasNew != null) {
			Context.error("Error: Do not not use new()", hasNew.pos);
		}

		for (field in fields) {
			if (field.access != null && field.access.contains(AStatic)) {
				continue;
			}
			if (field.name == "new") {
				continue;
			}

			switch (field.kind) {
				case FVar(type, expr):
					var isFunctionDelegate = false;

					if (type != null) {
						switch (type) {
							case TFunction(_, _):
								isFunctionDelegate = true;
							default:
						}
					}
					if (!isFunctionDelegate) {
						Context.error('Error: Field [${field.name}] is an instance field. Change this to static to make it a class field.', field.pos);
					}
				case FFun(_):
					// If they wrote a standard 'public function abc()', stop them too!
					Context.error('Error: Method [${field.name}] is an instance method. Change this to static to make it a class method.', field.pos);

				default:
			}
		}

		// ? This allows you to register a node at the top of your class.
		for (meta in localClass.meta.get()) {
			// trace(meta.name);
			if (meta.name == ":luantiNode") {
				final firstParameter = meta.params[0];

				if (firstParameter == null) {
					Context.error("luantiNode requires a string parameter", meta.pos);
				}
				switch (firstParameter.expr) {
					case EConst(CString((value))):
						{
							if (value.length == 0) {
								Context.error("luantiNode does not accept a blank string", meta.pos);
							}
							// And if it got this far then it's up to them to ensure it's a good name cause I do not fucking care at this point.
							final init: Field = Lambda.find(fields, (f: Field) -> f.name == "__init__");

							if (init != null) {
								// Inject code into their existing method
								switch (init.kind) {
									case FFun(func):
										if (func.expr != null) {
											var injectExpr = macro {
												luantitypes.Core.registerNode($v{value}, Type.createInstance($i{localClass.name}, []));
												// trace("Auto-injected node registration __init__ into " + $v{className});
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
									luantitypes.Core.registerNode($v{value}, Type.createInstance($i{localClass.name}, []));
									// trace("Auto-created node registration __init__ into " + $v{className});
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
						Context.error("luantiNode requires a string parameter", meta.pos);
				}
			}
		}
		return fields;
	}
}
#end // if macro
