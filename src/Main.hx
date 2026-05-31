import lua.Lua;
import luanti_types.Core;
import Reflect;
import Type;

class Vec3 {
	public var x: Float;
	public var y: Float;
	public var z: Float;

	public function new() {
		x = Math.random();
		y = Math.random();
		z = Math.random();
	}
}

abstract class Entity {
	var pos: Vec3;

	public function new(self: Entity, staticData: String, dtimeS: Float) {
		this.pos = new Vec3();
		trace("good day, I am an entity");
	}

	public static function toLuanti(input: Class<Entity>): Dynamic {
		// Static.
		trace("Class:", Type.getClassFields(input));
		// Instance.
		trace("Object:", Type.getInstanceFields(input));

		if (Reflect.field(input, "on_activate") != null) {
			throw "Do not use on_activate.";
		}

		var luantiTable: Dynamic = {};

		// Manually inject the new method into Luanti style.
		var constructorFunc: Dynamic = Reflect.field(input, "new");

		if (constructorFunc == null) {
			throw "Logic error. New missing from Entity derived class.";
		}

		luantiTable.on_activate = constructorFunc;

		trace(constructorFunc);

		return luantiTable;
	}
}

class Mob extends Entity {}

class Main {
	public static function main() {
		Entity.toLuanti(Mob);

		Core.registerEntity("haxe_luanti:test", Entity);

		Core.registerOnJoinPlayer(() -> {
			Core.requestShutdown();
		});
	};
}
