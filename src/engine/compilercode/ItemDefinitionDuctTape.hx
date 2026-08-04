package src.engine.compilercode;

#if macro
import haxe.macro.Context;
import haxe.macro.Expr;

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

		// todo: this should probably check for the weird type specific things (like groups)
		// todo: that was bolted on so things aren't accidentally cross-contaminated.

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

		// todo: Why doesn't this just return null???
		if (!isRoot) {
			if (!localClass.isFinal) {
				Context.error("Class must be final.", localClass.pos);
			}

			var superClassRef = localClass.superClass.t.get();
			var superClassName = superClassRef.name;

			var registerTag: Bool = localClass.meta.has(":register");
			var overrideTag: Bool = localClass.meta.has(":override");

			var isToolDef = (registerTag || overrideTag) && superClassName == "ToolDefinition";
			var isNodeDef = (registerTag || overrideTag) && superClassName == "NodeDefinition";
			var isItemDef = (registerTag || overrideTag) && superClassName == "ItemDefinition";
			var isOreDef = (registerTag || overrideTag) && superClassName == "OreDefinition";

			// trace(isItemDef, isToolDef, isNodeDef, className);

			if (!isItemDef && !isToolDef && !isNodeDef && !isOreDef) {
				switch (superClassRef.name) {
					case "ItemDefinition":
						Context.error('Please decorate this class with @:register("mod:item") or @:override("mod:item")', localClass.pos);
					case "NodeDefinition":
						Context.error('Please decorate this class with @:register("mod:node") or @:override("mod:node")', localClass.pos);
					case "ToolDefinition":
						Context.error('Please decorate this class with @:register("mod:tool") or @:override("mod:tool")', localClass.pos);
					case "OreDefinition":
						Context.error('Please decorate this class with @:register("mod:ore") or @:override("mod:ore")', localClass.pos);

					default:
						Context.error(superClassRef.name + ' IS MISSING A DECORATOR SWITCH!!!', localClass.pos);
				}
			}

			var registrationName;
			var luantiRegistrationMethod: Dynamic = null;

			// Override takes precedence over everything else.
			if (overrideTag) {
				luantiRegistrationMethod = macro untyped core.override_item;
			} else if (isItemDef) {
				luantiRegistrationMethod = macro untyped core.register_craftitem;
			} else if (isToolDef) {
				luantiRegistrationMethod = macro untyped core.register_tool;
			} else if (isNodeDef || isOreDef) {
				luantiRegistrationMethod = macro untyped core.register_node;
			}

			{
				var searchTag = registerTag ? ":register" : ":override";

				var metaEntry = localClass.meta.extract(searchTag)[0];
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
							Context.error("Could not parse @" + searchTag + " value as a string literal.", metaEntry.params[0].pos);
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

								// todo: turn this into one function.

								src.engine.definition.ItemDefinition.handleEveryItemType(
									$i{wrapperClassName},
									instance,
									$luantiRegistrationMethod,
									$v{registrationName},
									$v{isOreDef}
								);

								// ? This is important for debugging.
								// trace("registered " + $v{registrationName} + " with " + $v{luantiRegistrationMethod});

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
						code: "instance.onReceiveFields(pos, doNotUse, fields, sender)"
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
						classMethodName: "allowMetadataInventoryTake",
						luantiMethodName: "allow_metadata_inventory_take",
						code: "return instance.allowMetadataInventoryTake(pos, listName, index, stack, player)"
					},
					{
						classMethodName: "onMetadataInventoryMove",
						luantiMethodName: "on_metadata_inventory_move",
						code: "instance.onMetadataInventoryMove(pos, fromList, fromIndex, toList, toIndex, count, player)"
					},
					{
						classMethodName: "onMetadataInventoryPut",
						luantiMethodName: "on_metadata_inventory_put",
						code: "instance.onMetadataInventoryPut(pos, listName, index, stack, player)"
					},
					{
						classMethodName: "onMetadataInventoryTake",
						luantiMethodName: "on_metadata_inventory_take",
						code: "instance.onMetadataInventoryTake(pos, listName, index, stack, player)"
					},
					{
						classMethodName: "onBlast",
						luantiMethodName: "on_blast",
						code: "instance.onBlast(pos, intensity)"
					}
				]) {
					fieldChecks.push(data);
				}
			}

			// Only insert fields that are defined.
			// Defining all fields can cause weird behavior.
			for (implementation in fieldChecks) {
				final has = Lambda.find(fields, (f) -> f.name == implementation.classMethodName) != null;

				// ? This is extremely important for debugging meta static container classes!
				// trace(implementation.classMethodName, has);

				if (has) {
					var parsed = Context.parse(implementation.code, Context.currentPos());

					companionClassDefinition.fields.insert(companionClassDefinition.fields.length,
						{
							name: implementation.luantiMethodName,
							access: [AStatic],
							pos: Context.currentPos(),
							kind: FFun({
								args: grabArguments(implementation.classMethodName),
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
				// ? This is important for debugging.
				// trace('DuctTape: Successfully generated companion class: ' + localClass.pack.join(".") + "." + wrapperClassName);
			} catch (e:Dynamic) {
				// Prevent duplicate definition errors if the macro triggers multiple times.
			}
		}
		return null;
	}
}
#end // if macro
