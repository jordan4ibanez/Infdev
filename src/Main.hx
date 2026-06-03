import lua.Lua;
import luanti_types.Core;

class Vec3 {
	public var x: Float;
	public var y: Float;
	public var z: Float;

	public function new() {
		// trace("I am a new vec3");
		x = Math.random();
		y = Math.random();
		z = Math.random();
	}
}

@:autoBuild(luanti_types.EntityDuctTape.build())
@:build(luanti_types.EntityDuctTape.build())
class Entity {
	var pos: Vec3 = new Vec3();
	var uuid: Int = 0;

	// This returns this.
	public function new() {}

	public function on_activate(staticData: String, dtimeS: Float) {}

	public function on_step() {
		// Lua.print(this.uuid);
	}

	public static function testing() {
		Lua.print("Hello I am a test!");
	}
}

// TODO: Move this thing back into the Core as an inline
class EntityRegistrationTesting {
	// This is the hijacked function.
	static public inline function registerEntity(name: String, clazz: Class<Entity>): Void {
		var rawLuantiPrototype: Dynamic = {}

		// ? Works from the current class backwards until reached root (Entity).
		var currentClass: Class<Dynamic> = clazz;

		while (currentClass != null) {
			// trace("in class: " + Type.getClassName(currentClass));

			// Class components.
			var prototype = Reflect.field(currentClass, "prototype");

			for (method in Reflect.fields(prototype)) {
				untyped {
					if (rawLuantiPrototype[method] != null) {
						// trace("skipping method " + method + " already has it from child class");
						continue;
					}

					rawLuantiPrototype[method] = Reflect.getProperty(prototype, method);
				}
				// trace(method);
			}

			// Move up the inheritance tree.
			currentClass = Type.getSuperClass(currentClass);
		}

		Core.register_entity(name, rawLuantiPrototype);
	}
}

// class Mob extends Entity {
// 	var myCoolName = "fred";
// 	override function on_activate(staticData: String, dtimeS: Float) {
// 		super.on_activate(staticData, dtimeS);
// 	}
// }

class Main {
	public static function main() {
		EntityRegistrationTesting.registerEntity("haxe_luanti:test", Entity);

		Core.registerOnJoinPlayer(() -> {
			// Core.requestShutdown();
		});
	};
}
