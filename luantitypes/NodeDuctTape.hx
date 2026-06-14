package luantitypes;

#if macro
import haxe.macro.Context;
import haxe.macro.Expr;

class NodeDuctTape {
	public static function build(): Array<Field> {
		var fields = Context.getBuildFields();

		var localClass = Context.getLocalClass().get();

		// Fully qualified.
		var className = Context.getLocalClass().toString();

		final hasNew: Field = Lambda.find(fields, (f: Field) -> f.name == "new");
		if (hasNew != null) {
			Context.error("Error: Do not not use new()", hasNew.pos);
		}

		// todo: destroy this parameter from every function.
		// todo: do not allow super call.
		// todo: just fuck this shit up and make nodes act weird as fuck but work properly.

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
												luantitypes.Core.registerNode($v{value}, $i{localClass.name});
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
									luantitypes.Core.registerNode($v{value}, $i{localClass.name});
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
