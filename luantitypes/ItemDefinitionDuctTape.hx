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

/*
	AI also heavily guided this development cause this is a fucking mess.
	This is cramming OOP into lua style static everything while trying to make it
	not a horrific mess to use.
	THIS WAS A HORROR TO TRY TO DESIGN.

	Basically:

	Your class gets wrapped in a static virtual class.

	Only methods that you explicitly define get static methods defined.

	This prevents weird behavior.
 */
class ItemDefinitionDuctTape {
	public static function build(): Array<Field> {
		var fields = Context.getBuildFields();

		var localClass = Context.getLocalClass().get();

		var originalImports = Context.getLocalImports();

		// Fully qualified.
		var className = Context.getLocalClass().toString();

		final hasNew: Field = Lambda.find(fields, (f: Field) -> f.name == "new");
		if (hasNew == null) {
			Context.error("This requires a constructor.", localClass.pos);
		} else {
			switch (hasNew.kind) {
				case FFun(f):
					if (f.args.length != 0) {
						Context.error("This constructor requires no parameters.", hasNew.pos);
					}
				default:
			}
		}

		// for (meta in localClass.meta.get()) {
		// 	trace(meta.name);
		// }

		final isRoot = localClass.meta.has(":luantiDefinitionRoot");

		if (!isRoot) {
			if (!localClass.isFinal) {
				Context.error("Class must be final.", localClass.pos);
			}

			var superClassRef = localClass.superClass.t.get();
			var superClassName = superClassRef.name;

			var registerTag = localClass.meta.has(":register");

			var isToolDef = registerTag && superClassName == "ToolDefinition";
			var isNodeDef = registerTag && superClassName == "NodeDefinition";
			var isItemDef = registerTag && superClassName == "ItemDefinition";

			// trace(isItemDef, isToolDef, isNodeDef, className);

			if (!isItemDef && !isToolDef && !isNodeDef) {
				switch (superClassRef.name) {
					case "ItemDefinition":
						Context.error('Please decorate this class with @:register("mod:item")', localClass.pos);
					case "NodeDefinition":
						Context.error('Please decorate this class with @:register("mod:node")', localClass.pos);
					case "ToolDefinition":
						Context.error('Please decorate this class with @:register("mod:tool")', localClass.pos);

					default:
						Context.error(superClassRef.name + ' IS MISSING A DECORATOR SWITCH!!!', localClass.pos);
				}
			}

			var registrationName;
			var luantiRegistrationMethod;

			if (isItemDef) {
				luantiRegistrationMethod = "registerCraftItem";
			} else if (isToolDef) {
				luantiRegistrationMethod = "registerTool";
			} else if (isNodeDef) {
				luantiRegistrationMethod = "registerNode";
			}

			{
				var metaEntry = localClass.meta.extract(":register")[0];
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
							Context.error("Could not parse @:register value as a string literal.", metaEntry.params[0].pos);
						}
				}
			}
			// trace(registrationName);

			var wrapperClassName = localClass.name + "Wrapper";

			var localClassComplexType = Context.toComplexType(TInst(Context.getLocalClass(), []));

			// ? Set up the raw static wrapper class first.

			var companionClassDefinition: TypeDefinition = {
				pack: localClass.pack, // Places it in the exact same package/folder path.
				name: wrapperClassName,
				pos: Context.currentPos(),
				kind: TDClass(null, null, false, true, false), // Final.
				fields: [
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

								// This dumps the fields from the class defined into the wrapper class in lua.
								for (field in Reflect.fields(instance)) {
									if (field == "mod_origin") {
										// trace("[DEBUG]: skipped mod_origin for " + $v{wrapperClassName});
										continue;
									}
									trace($v{wrapperClassName}, "field", field);
									untyped $i{wrapperClassName}[field] = Reflect.field(instance, field);
								}

								// This hackjob automatically does the registration.
								luantitypes.Core.$luantiRegistrationMethod($v{registrationName}, $i{wrapperClassName});

								trace("registered " + $v{registrationName} + " with " + $v{luantiRegistrationMethod});

								// trace(instance);
								// trace($i{wrapperClassName});
							}
						})
					}
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
										arg.type = Context.toComplexType(Context.resolveType(arg.type, Context.currentPos()));
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

			function grabReturnType(methodName: String): ComplexType {
				var func = Lambda.find(fields, (f) -> f.name == methodName);

				if (func != null) {
					switch (func.kind) {
						case FFun(f):
							// If there's no explicit return type written, let Haxe infer it.
							if (f.ret == null) {
								return null;
							}

							try {
								return Context.toComplexType(Context.resolveType(f.ret, func.pos));
							} catch (e:Dynamic) {
								return f.ret;
							}
						case _:
							Context.error(methodName + " is defined, but it is not a function.", func.pos);
					}
				}

				Context.error("Failed to resolve return type in" + methodName, func.pos);

				return null;
			}

			var fieldChecks: Array<MethodMatcherThing> = [];

			// ItemDefinition. (short circuits to true because it's the base of the other 2)
			if (true) {
				for (data in [
					{
						classMethodName: "onPlace",
						luantiMethodName: "on_place",
						code: "return instance.onPlace(itemstack, placer, pointedThing)"
					},
					{
						classMethodName: "onSecondaryUse",
						luantiMethodName: "on_secondary_use",
						code: "return instance.onSecondaryUse(itemstack, user, pointedThing)"
					},
					{
						classMethodName: "onDrop",
						luantiMethodName: "on_drop",
						code: "return instance.onDrop(itemstack, dropper, pos)"
					},
					{
						classMethodName: "onPickup",
						luantiMethodName: "on_pickup",
						code: "return instance.onPickup(itemstack, picker, pointedThing, timeFromLastPunch)"
					},
					{
						classMethodName: "onUse",
						luantiMethodName: "on_use",
						code: "return instance.onUse(itemstack, user, pointedThing)"
					},
					{
						classMethodName: "afterUse",
						luantiMethodName: "after_use",
						code: "return instance.afterUse(itemstack, user, node, digparams)"
					},
				]) {
					fieldChecks.push(data);
				}
			}

			// NodeDefinition.
			if (isNodeDef) {
				for (data in [
					{
						classMethodName: "onConstruct",
						luantiMethodName: "on_construct",
						code: "instance.onConstruct(pos)"
					},
					{
						classMethodName: "onDestruct",
						luantiMethodName: "on_destruct",
						code: "instance.onDestruct(pos)"
					},
					{
						classMethodName: "afterDestruct",
						luantiMethodName: "after_destruct",
						code: "instance.afterDestruct(pos, oldNode)"
					},
					{
						classMethodName: "onFlood",
						luantiMethodName: "on_flood",
						code: "return instance.onFlood(pos, oldNode, newNode)"
					},
					{
						classMethodName: "preserveMetadata",
						luantiMethodName: "preserve_metadata",
						code: "instance.preserveMetadata(pos, oldNode, oldMeta, drops)"
					},
					{
						classMethodName: "afterPlaceNode",
						luantiMethodName: "after_place_node",
						code: "return instance.afterPlaceNode(pos, placer, itemStack, pointedThing)"
					},
					{
						classMethodName: "afterDigNode",
						luantiMethodName: "after_dig_node",
						code: "instance.afterDigNode(pos, oldNode, oldMetaData, digger)"
					},
					{
						classMethodName: "canDig",
						luantiMethodName: "can_dig",
						code: "return instance.canDig(pos, player)"
					},
					{
						classMethodName: "onPunch",
						luantiMethodName: "on_punch",
						code: "instance.onPunch(pos, node, puncher, pointedThing)"
					},
					{
						classMethodName: "onRightClick",
						luantiMethodName: "on_rightclick",
						code: "return instance.onRightClick(pos, node, clicker, itemStack, pointedThing)"
					},
					{
						classMethodName: "onDig",
						luantiMethodName: "on_dig",
						code: "return instance.onDig(pos, node, digger)"
					},
					{
						classMethodName: "onTimer",
						luantiMethodName: "on_timer",
						code: "return instance.onTimer(pos, elapsed, node, timeout)"
					},
					{
						classMethodName: "onReceiveFields",
						luantiMethodName: "on_receive_fields",
						code: "instance.onReceiveFields(pos, formName, fields, sender)"
					},
					{
						classMethodName: "allowMetadataInventoryMove",
						luantiMethodName: "allow_metadata_inventory_move",
						code: "return instance.allowMetadataInventoryMove(pos, fromList, fromIndex, toList, toIndex, count, player)"
					},
					{
						classMethodName: "allowMetadataInventoryPut",
						luantiMethodName: "allow_metadata_inventory_put",
						code: "return instance.allowMetadataInventoryPut(pos, listName, index, stack, player)"
					},
					{
						classMethodName: "",
						luantiMethodName: "",
						code: ""
					},
					{
						classMethodName: "",
						luantiMethodName: "",
						code: ""
					},
					{
						classMethodName: "",
						luantiMethodName: "",
						code: ""
					},
					{
						classMethodName: "",
						luantiMethodName: "",
						code: ""
					},
					{
						classMethodName: "",
						luantiMethodName: "",
						code: ""
					}
				]) {
					fieldChecks.push(data);
				}
			}

			// Only insert fields that are defined.
			// Defining all fields can cause weird behavior.
			for (implementation in fieldChecks) {
				final has = Lambda.find(fields, (f) -> f.name == implementation.classMethodName) != null;

				trace(implementation.classMethodName, has);

				if (has) {
					var parsed = Context.parse(implementation.code, Context.currentPos());

					companionClassDefinition.fields.insert(companionClassDefinition.fields.length,
						{
							name: implementation.luantiMethodName,
							access: [AStatic],
							pos: Context.currentPos(),
							kind: FFun({
								args: grabArguments(implementation.classMethodName),
								// todo: Grab return
								ret: grabReturnType(implementation.classMethodName),
								expr: macro {
									$parsed;
								}
							})
						});
				}
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
