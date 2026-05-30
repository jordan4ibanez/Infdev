import lua.Lua;
import luanti_types.Core;
import Reflect;
import Type;

class Vec3 {
	var x:Float;
	var y:Float;
	var z:Float;

	public function new() {
		x = Math.random();
		y = Math.random();
		z = Math.random();
	}
}

class Entity {
	var pos:Vec3;

	public function new(self:Entity) {
		this.pos = new Vec3();
		Lua.print("hi");
	}

	public static function toLuanti(input:Class<Entity>):Dynamic {
		return 5;
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
