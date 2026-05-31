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

	public function on_step(): Void {
		trace("hi");
	}

	public static function toLuanti(classType: Class<Entity>): Dynamic {
		if (Reflect.field(classType, "on_activate") != null) {
			throw "Do not use on_activate.";
		}

		var luantiTable: Dynamic = {};

		// ? Static and instance field assignment in LuaJIT.
		// ? Works from the current class backwards until reached root (Entity).

		var currentClass = classType;

		while (currentClass != null) {

		// ? Static.

		var staticFields = Reflect.fields(classType);

		for (field in staticFields) {
			trace("static", field);
			switch (field) {
				case "new":
					{
						// ? Note: This is manually hardwiring in the constructor into on_activate.
						// Manually inject the new method into Luanti style.
						var constructorFunc: Dynamic = Reflect.field(input, "new");
						if (constructorFunc == null) {
							throw "Logic error. New missing from Entity derived class.";
						}
						luantiTable.on_activate = constructorFunc;
						// ? End hardwire.
					}
				default:
					{
						// Don't overwrite child overrides. (Probably not needed for static. [But this is very complex so I'm not taking chances.])
						if (Reflect.hasField(luantiTable, field)) {
							trace("Warning: Skipping static class data", field);
							continue;
						}
						var dataValue = Reflect.field(input, field);
						// todo: do stuff with it (if needed)
						Reflect.setField(luantiTable, field, dataValue);
					}
			}
		}

		// ? Instance.
		var prototype: Dynamic = Reflect.field(classType, "prototype");
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
		}

		return luantiTable;
	}
}

class Mob extends Entity {}

class Main {
	public static function main() {
		Core.registerEntity("haxe_luanti:test", Entity.toLuanti(Entity));

		Core.registerOnJoinPlayer(() -> {
			Core.requestShutdown();
		});
	};
}
