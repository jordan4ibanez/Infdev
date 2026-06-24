package src.engine;

import luantitypes.Macros;
import luantitypes.Core;
import src.engine.entity.LuaEntity;
import haxe.Constraints.Constructible;

class Helpers {
	public static function toLuanti(classType: Class<Dynamic>): Dynamic {
		if (Reflect.field(classType, "on_activate") != null) {
			throw "Do not use on_activate.";
		}

		var luantiTable: Dynamic = {};

		// ? Static and instance field assignment in LuaJIT.
		// ? Works from the current class backwards until reached root (Entity).

		var currentClass: Class<Dynamic> = classType;

		while (currentClass != null) {
			trace(" ===== in class: ", Type.getClassName(currentClass), "=====");

			// ? Static.

			var staticFields = Reflect.fields(currentClass);

			for (field in staticFields) {
				// Don't overwrite child overrides.
				// ? new is hardwired to on_activate so it gets a special check.
				if (Reflect.hasField(luantiTable, field) || (field == "new" && Reflect.hasField(luantiTable, "on_activate"))) {
					trace("Warning: Skipping static class data", field);
					continue;
				} else {
					trace("static", field);
				}
				switch (field) {
					case "new":
						{
							// ? Note: This is manually hardwiring in the constructor into on_activate.
							// Manually inject the new method into Luanti style.
							var constructorFunc: Dynamic = Reflect.field(currentClass, "new");
							if (constructorFunc == null) {
								throw "Logic error. New missing from Entity derived class.";
							}
							luantiTable.on_activate = constructorFunc;
							// ? End hardwire.
						}
					default:
						{
							var dataValue = Reflect.field(currentClass, field);
							// todo: do stuff with it (if needed)
							Reflect.setField(luantiTable, field, dataValue);
						}
				}
			}

			// ? Instance.
			var prototype: Dynamic = Reflect.field(currentClass, "prototype");
			var instanceFields = Reflect.fields(prototype);
			for (field in instanceFields) {
				// Don't overwrite child overrides.
				if (Reflect.hasField(luantiTable, field)) {
					trace("Warning: Skipping instance class data", field);
					continue;
				} else {
					trace("instance", field);
				}
				var instanceDataValue = Reflect.field(prototype, field);
				// ? Only map functions. Everything else is null.
				if (Reflect.isFunction(instanceDataValue)) {
					Reflect.setField(luantiTable, field, instanceDataValue);
				}
			}

			// Move up the inheritance tree.
			currentClass = Type.getSuperClass(currentClass);
		}

		// trace("DATA", Global.dump(luantiTable));

		return luantiTable;
	}
}
