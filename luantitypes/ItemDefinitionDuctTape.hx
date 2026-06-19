package luantitypes;

#if macro
import haxe.macro.Context;
import haxe.macro.Expr;
import haxe.macro.Type;
import haxe.macro.ExprTools;
import haxe.macro.Expr.FieldType;

typedef MethodMatcherThing = {
	public var classMethodName: String;
	public var luantiMethodName: String;
	public var code: String;
}

// AI also heavily guided this development cause this is a fucking mess.
// This is cramming OOP into lua style static everything while trying to make it
// not a horrific mess to use.
// THIS WAS A HORROR TO TRY TO DESIGN.
class ItemDefinitionDuctTape {
	public static function build(): Array<Field> {
		var fields = Context.getBuildFields();

		var localClass = Context.getLocalClass().get();

		var originalImports = Context.getLocalImports();

		// Fully qualified.
		var className = Context.getLocalClass().toString();

		final isInterface = localClass.isInterface;

		final hasNew: Field = Lambda.find(fields, (f: Field) -> f.name == "new");
		if (hasNew == null) {
			Context.error("luantiNode requires a constructor so you can edit the class fields.", localClass.pos);
		} else {
			switch (hasNew.kind) {
				case FFun(f):
					if (f.args.length != 0) {
						Context.error("luantiNode constructor requires no parameters", hasNew.pos);
					}
				default:
			}
		}

		// for (meta in localClass.meta.get()) {
		// 	trace(meta.name);
		// }

		final isRoot = localClass.meta.has(":luantiDefinitionRoot");

		if (!isRoot) {
			final isItemDef = localClass.meta.has(":luantiItem");
			final isToolDef = localClass.meta.has(":luantiTool");
			final isNodeDef = localClass.meta.has(":luantiNode");

			// trace(isItemDef, isToolDef, isNodeDef, className);

			if (!isItemDef && !isToolDef && !isNodeDef) {
				Context.error('Error: Something went seriously wrong.', localClass.pos);
			}

			// ItemDefinition.
			var onPlace = false;
			var onSecondaryUse = false;
			var onDrop = false;
			var onPickup = false;
			var onUse = false;
			var afterUse = false;

			for (field in fields) {
				final fieldName = field.name;

				switch (fieldName) {
					// ItemDefinition.

					case "onPlace":
						onPlace = true;
					case "onSecondaryUse":
						onSecondaryUse = true;
					case "onDrop":
						onDrop = true;
					case "onPickup":
						onPickup = true;
					case "onUse":
						onUse = true;
					case "afterUse":
						afterUse = true;
				}
			}

			var registrationName;
			var metaSearchTerm;
			var luantiRegistrationMethod;

			if (isItemDef) {
				metaSearchTerm = ":luantiItem";
				luantiRegistrationMethod = "registerCraftItem";
			} else if (isToolDef) {
				metaSearchTerm = ":luantiTool";
				luantiRegistrationMethod = "registerTool";
			} else if (isNodeDef) {
				metaSearchTerm = ":luantiNode";
				luantiRegistrationMethod = "registerNode";
			}

			{
				var metaEntry = localClass.meta.extract(metaSearchTerm)[0];
				// trace(metaEntry);
				if (metaEntry == null) {
					Context.error("Something blew up.", localClass.pos);
				}
				var constantEnum = metaEntry.params[0].expr.getParameters()[0];
				switch (constantEnum) {
					case CString(s, _):
						registrationName = s;
					case _:
						try {
							registrationName = haxe.macro.ExprTools.getValue(metaEntry.params[0]);
						} catch (e:Dynamic) {
							Context.error("Could not parse @:luantiItem value as a string literal.", metaEntry.params[0].pos);
						}
				}
			}
			// trace(registrationName);

			var metaEntry = localClass.meta.extract(":luantiItem")[0];

			var wrapperClassName = localClass.name + "Wrapper";

			var localClassComplexType = Context.toComplexType(TInst(Context.getLocalClass(), []));

			// ? Set up the raw static wrapper class first.

			var companionClassDefinition: TypeDefinition = {
				pack: localClass.pack, // Places it in the exact same package/folder path.
				name: wrapperClassName,
				pos: Context.currentPos(),
				kind: TDClass(null, null, false, true, false), // Final.
				fields: [
					// {
					// 	name: "ITEM_ID",
					// 	access: [APublic, AStatic, AFinal],
					// 	kind: FVar(macro : String, macro $v{wrapperClassName}),
					// 	pos: Context.currentPos()
					// },
					{
						name: "instance",
						access: [AStatic],
						pos: Context.currentPos(),
						kind: FVar(localClassComplexType, null)
					},
					{
						name: "__init__",
						access: [AStatic],
						pos: Context.currentPos(),
						kind: FFun({
							args: [],
							ret: null,
							expr: macro {
								instance = Type.createInstance(Type.resolveClass($v{className}), []);

								for (field in Reflect.fields(instance)) {
									trace("field", field);
									untyped DirtWrapper[field] = Reflect.field(instance, field);
								}

								// This hackjob automatically does the registration.
								luantitypes.Core.$luantiRegistrationMethod($v{registrationName}, $i{wrapperClassName});

								trace("registered " + $v{registrationName} + " with " + $v{luantiRegistrationMethod});

								trace(instance);
							}
						})
					}
					// Static factory method.
					// {
					// 	name: "createInstance",
					// 	access: [APublic, AStatic],
					// 	kind: FFun({
					// 		args: [],
					// 		ret: TPath({pack: ["engine.definition"], name: "ItemDefinition"}),
					// 		expr: macro {
					// 			return Type.createInstance(Type.resolveClass($v{
					// 				localClass.pack.join(".") + (localClass.pack.length > 0 ? "." : "") + localClass.name}), []);
					// 		}
					// 	}),
					// 	pos: Context.currentPos()
					// }
				],
				meta: []
			};

			// ? Next, inject any static wrapper methods into the static wrapper class.

			// This function is so this isn't a complete mess.
			// This thing has an auto resolver in it.

			function grabArguments(methodName: String): Array<FunctionArg> {
				var funcOnPlace = Lambda.find(fields, (f) -> f.name == methodName);
				if (funcOnPlace != null) {
					switch (funcOnPlace.kind) {
						case FFun(func):
							var argsCopy = func.args.copy();
							for (arg in argsCopy) {
								if (arg.type != null) {
									try {
										var resolvedType = Context.resolveType(arg.type, Context.currentPos());

										arg.type = Context.toComplexType(resolvedType);
									} catch (e:Dynamic) {}
								}
							}
							return argsCopy;
						case _:
							Context.error(methodName + " is defined, but it is not a function.", funcOnPlace.pos);
					}
				} else {
					Context.error("Could not find " + methodName + " in the build fields.", Context.currentPos());
				}
				return [];
			}

			// ItemDefinition.

			if (onPlace) {
				companionClassDefinition.fields.insert(companionClassDefinition.fields.length,
					{
						name: "on_place",
						access: [AStatic],
						pos: Context.currentPos(),
						kind: FFun({
							args: grabArguments("onPlace"),
							ret: null,
							expr: macro {
								return instance.onPlace(itemstack, placer, pointedThing);
							}
						})
					});
			}

			// ? Finally inject the class directly into the compiler compilation pool.

			try {
				Context.defineType(companionClassDefinition);
				trace('DuctTape: Successfully generated companion class: ' + localClass.pack.join(".") + "." + wrapperClassName);
			} catch (e:Dynamic) {
				// Prevent duplicate definition errors if the macro triggers multiple times.
			}
		}

		// ? This allows you to register a node at the top of your class.
		// for (meta in localClass.meta.get()) {
		// 	// trace(meta.name);
		// 	if (meta.name == ":luantiNode") {
		// 		if (isInterface) {
		// 			Context.error('Error: Do not use :luantiNode on an interface.', meta.pos);
		// 		}

		// 		final firstParameter = meta.params[0];

		// 		if (firstParameter == null) {
		// 			Context.error("luantiNode requires a string parameter", meta.pos);
		// 		}
		// 		switch (firstParameter.expr) {
		// 			case EConst(CString((value))):
		// 				{
		// 					if (value.length == 0) {
		// 						Context.error("luantiNode does not accept a blank string", meta.pos);
		// 					}
		// 					// And if it got this far then it's up to them to ensure it's a good name cause I do not fucking care at this point.
		// 					final init: Field = Lambda.find(fields, (f: Field) -> f.name == "__init__");

		// 					var typePath: haxe.macro.Expr.TypePath = {
		// 						pack: localClass.pack,
		// 						name: localClass.name,
		// 						params: []
		// 					};

		// 					if (init != null) {
		// 						// Inject code into their existing method
		// 						switch (init.kind) {
		// 							case FFun(func):
		// 								if (func.expr != null) {
		// 									var injectExpr = macro {
		// 										trace("Auto-injected node registration __init__ into " + $v{className});
		// 										var instance = new $typePath();
		// 										// This fixes haxe injecting reflection into the groups.
		// 										untyped __lua__("
		// 										if instance and instance.groups and type(instance.groups) == 'table' then
		// 											instance.groups['__fields__'] = nil;
		// 										end
		// 										");
		// 										luantitypes.Core.registerNode($v{value}, instance);
		// 										// Wipe out the context.
		// 										untyped __lua__("instance = nil;");
		// 									};

		// 									switch (func.expr.expr) {
		// 										case EBlock(exprs): exprs.unshift(injectExpr);
		// 										default: func.expr = macro {
		// 												$injectExpr;
		// 												${func.expr};
		// 											};
		// 									}
		// 								}
		// 							default:
		// 								Context.error("__init__ is wrong?", init.pos);
		// 						}
		// 					} else {
		// 						var newFunction = macro function() {
		// 							trace("Auto-created node registration __init__ into " + $v{className});
		// 							var instance = new $typePath();
		// 							// This fixes haxe injecting reflection into the groups.
		// 							untyped __lua__("
		// 							if instance and instance.groups and type(instance.groups) == 'table' then
		// 								instance.groups['__fields__'] = nil;
		// 							end
		// 							");
		// 							luantitypes.Core.registerNode($v{value}, instance);
		// 							// Wipe out the context.
		// 							untyped __lua__("instance = nil;");
		// 						};
		// 						switch (newFunction.expr) {
		// 							case EFunction(_, func):
		// 								fields.push({
		// 									name: "__init__",
		// 									access: [AStatic],
		// 									kind: FFun(func),
		// 									pos: Context.currentPos()
		// 								});
		// 							default:
		// 								Context.error("Something exploded in the entity duct tape patch __init__.", Context.currentPos());
		// 						}
		// 					}
		// 				}
		// 			default:
		// 				Context.error("luantiNode requires a string parameter", meta.pos);
		// 		}
		// 	}
		// }
		return null;
	}
}
#end // if macro
