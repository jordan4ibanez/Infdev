import lua.Lua;
import luanti_types.Core;
import Reflect;
import Type;

class Vec3 {
	public var x: Float;
	public var y: Float;
	public var z: Float;

	public function new() {
		trace("I am a new vec3");
		x = Math.random();
		y = Math.random();
		z = Math.random();
	}
}

abstract class Entity {
	var pos: Vec3 = new Vec3();

	public function new(_: Null<Any>, staticData: String, dtimeS: Float) {
		// this.pos = new Vec3();
		trace("good day, I am an entity", this.pos);
		// Lua.print("[" + staticData + "]", dtimeS);
	}

	@:native("on_step")
	public function onStep(delta: Float): Void {}

	public static function toLuanti(classType: Class<Dynamic>): Dynamic {
		if (Reflect.field(classType, "on_activate") != null) {
			throw "Do not use on_activate.";
		}

		var luantiTable: Dynamic = {};

		// ? Static and instance field assignment in LuaJIT.
		// ? Works from the current class backwards until reached root (Entity).

		// todo: look into this, it may be wrong.
		var currentClass: Class<Dynamic> = classType;

		while (currentClass != null) {
			trace(" ===== in class: ", Type.getClassName(currentClass), "=====");

			// ? Static.

			var staticFields = Reflect.fields(currentClass);

			for (field in staticFields) {
				trace("static", field);
				// Don't overwrite child overrides.
				if (Reflect.hasField(luantiTable, field)) {
					trace("Warning: Skipping static class data", field);
					continue;
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
				trace("instance", field);
				// Don't overwrite child overrides.
				if (Reflect.hasField(luantiTable, field)) {
					trace("Warning: Skipping instance class data", field);
					continue;
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

		return luantiTable;
	}
}

class Mob extends Entity {}

class Main {
	public static function main() {
		Core.registerEntity("haxe_luanti:test", Entity.toLuanti(Mob));

		Core.registerOnJoinPlayer(() -> {
			Core.requestShutdown();
		});
	};
}
