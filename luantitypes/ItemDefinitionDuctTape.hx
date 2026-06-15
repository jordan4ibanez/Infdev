package luantitypes;

#if macro
import haxe.macro.Context;
import haxe.macro.Expr;

// AI also heavily guided this development cause this is a fucking mess.
// This is cramming OOP into lua style static everything while trying to make it
// not a horrific mess to use.
// THIS WAS A HORROR TO TRY TO DESIGN.
class ItemDefinitionDuctTape {
	public static function build(): Array<Field> {
		var fields = Context.getBuildFields();

		var localClass = Context.getLocalClass().get();

		// Fully qualified.
		var className = Context.getLocalClass().toString();

		final isInterface = localClass.isInterface;

		final hasNew: Field = Lambda.find(fields, (f: Field) -> f.name == "new");
		if (hasNew != null) {
			Context.error("Error: Do not not use new()", hasNew.pos);
		} else if (!isInterface) {
			// It gets a blank new injected so the instance can be sent to the engine.
			var dummy = macro class {
				public function new() {}
			};

			var autoConstructor = dummy.fields[0];
			autoConstructor.pos = Context.currentPos();
			fields.push(autoConstructor);
		}

		// ? This checks everything to make sure things aren't gonna cause issues.
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

		// Search for the original metadata and inherit it.
		// This was truly horrific to figure out how to implement.
		if (!isInterface) {
			for (field in fields) {
				var origin = findOriginatingInterface(localClass.interfaces, field.name);

				if (origin != null) {
					var origin = findOriginatingInterface(localClass.interfaces, field.name);

					if (origin != null) {
						// trace('Field "${field.name}" originally came from interface: ' + origin.name);

						var interfaceField = Lambda.find(origin.fields.get(), f -> f.name == field.name);
						if (interfaceField != null && interfaceField.meta.has(":native")) {
							var nativeMeta = interfaceField.meta.get().filter(m -> m.name == ":native")[0];

							if (field.meta == null) {
								field.meta = [];
							}

							var alreadyHasNative = Lambda.exists(field.meta, (m) -> m.name == ":native");

							if (!alreadyHasNative) {
								field.meta.push(nativeMeta);
								// trace('Successfully copied @:native("${nativeMeta.params[0].expr}") onto concrete field: ${field.name}');
							}
						}
					}
				}
			}
		}

		// ? This allows you to register a node at the top of your class.
		for (meta in localClass.meta.get()) {
			// trace(meta.name);
			if (meta.name == ":luantiNode") {
				if (isInterface) {
					Context.error('Error: Do not use :luantiNode on an interface.', meta.pos);
				}

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

							var typePath: haxe.macro.Expr.TypePath = {
								pack: localClass.pack,
								name: localClass.name,
								params: []
							};

							if (init != null) {
								// Inject code into their existing method
								switch (init.kind) {
									case FFun(func):
										if (func.expr != null) {
											var injectExpr = macro {
												trace("Auto-injected node registration __init__ into " + $v{className});
												luantitypes.Core.registerNode($v{value}, new $typePath());
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
								var newFunction = macro function() {
									trace("Auto-created node registration __init__ into " + $v{className});
									luantitypes.Core.registerNode($v{value}, new $typePath());
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
