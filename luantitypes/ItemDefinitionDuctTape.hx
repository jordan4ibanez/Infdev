package luantitypes;

#if macro
import haxe.macro.Context;
import haxe.macro.Expr;
import haxe.macro.Type;

// AI also heavily guided this development cause this is a fucking mess.
// This is cramming OOP into lua style static everything while trying to make it
// not a horrific mess to use.
// THIS WAS A HORROR TO TRY TO DESIGN.
class ItemDefinitionDuctTape {
	static function findOriginatingInterface(interfaces: Array<{t: Ref<ClassType>, params: Array<Type>}>, fieldName: String): ClassType {
		for (wrapper in interfaces) {
			var interfaceType = wrapper.t.get();

			for (f in interfaceType.fields.get()) {
				if (f.name == fieldName) {
					return interfaceType;
				}
			}

			var deepOrigin = findOriginatingInterface(interfaceType.interfaces, fieldName);
			if (deepOrigin != null) {
				return deepOrigin;
			}
		}

		return null;
	}

	// Don't let people access `this`.
	static function checkThisAccess(field: haxe.macro.Expr.Field, fields: Array<Field>, localClass: haxe.macro.Type.ClassType) {
		// Gather a list of ALL instance fields that are forbidden from implicit scope access.
		var forbiddenNames = new Map<String, Bool>();

		// Add instance fields from the current class definition.
		for (f in fields) {
			if (f.access == null || !f.access.contains(AStatic)) {
				if (f.name != "new") {
					forbiddenNames.set(f.name, true);
				}
			}
		}

		// Get instance fields from implemented interfaces too.
		function gatherInterfaceFields(interfaces: Array<{t: haxe.macro.Type.Ref<haxe.macro.Type.ClassType>, params: Array<haxe.macro.Type>}>) {
			for (wrapper in interfaces) {
				var it = wrapper.t.get();
				for (f in it.fields.get()) {
					forbiddenNames.set(f.name, true);
				}
				gatherInterfaceFields(it.interfaces);
			}
		}
		gatherInterfaceFields(localClass.interfaces);

		// Local helper to scan the expressions recursively.
		function walk(expr: haxe.macro.Expr) {
			if (expr == null)
				return;

			switch (expr.expr) {
				// Catch literal "this" usage (this.description)
				case EConst(CIdent("this")):
					Context.error('Error: "this" keyword is forbidden here. ItemDefinition, NodeDefinition, ToolDefinition, and CraftItemDefinition are fully static.',
						expr.pos);

				// Catch implicit identifier usage (description = "hi" or trace(description))
				case EConst(CIdent(name)):
					if (forbiddenNames.exists(name)) {
						Context.error('Error: Do not access instance field [${name}].\nMake this variable static or don\'t access it if it\'s interface implementation.\n'
							+ "ItemDefinition, NodeDefinition, ToolDefinition, and CraftItemDefinition are fully static.",
							expr.pos);
					}

				default:
					haxe.macro.ExprTools.iter(expr, walk);
			}
		}

		// Scan the field payload.
		switch (field.kind) {
			case FVar(_, expr):
				walk(expr);
			case FFun(f):
				walk(f.expr);
			default:
		}
	}

	public static function build(): Array<Field> {
		var fields = Context.getBuildFields();

		var localClass = Context.getLocalClass().get();

		// Fully qualified.
		var className = Context.getLocalClass().toString();

		final isInterface = localClass.isInterface;

		final hasNew: Field = Lambda.find(fields, (f: Field) -> f.name == "new");
		if (hasNew == null) {
			Context.error("luantiNode requires a constructor so you can edit the class fields.", localClass.pos);
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
												var instance = new $typePath();
												// This fixes haxe injecting reflection into the groups.
												untyped __lua__("
												if instance and instance.groups and type(instance.groups) == 'table' then
													instance.groups['__fields__'] = nil;
												end
												");
												luantitypes.Core.registerNode($v{value}, instance);
												// Wipe out the context.
												untyped __lua__("instance = nil;");
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
									var instance = new $typePath();
									// This fixes haxe injecting reflection into the groups.
									untyped __lua__("
									if instance and instance.groups and type(instance.groups) == 'table' then
										instance.groups['__fields__'] = nil;
									end
									");
									luantitypes.Core.registerNode($v{value}, instance);
									// Wipe out the context.
									untyped __lua__("instance = nil;");
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
