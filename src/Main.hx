import lua.Lua;
import luanti_types.Core;
import Reflect;
import Type;

abstract class Entity {
	@:native("on_activate")
	function onActivate(self:Entity) {
		trace("hello from entity!");
	}
}

// class Mob extends Entity {
// 	override function onActivate(self:Entity) {
// 		trace("I am overloaded");
// 	}
// }

class Main {
	public static function main() {
		// Core.log(error, "testing");

		// Core.registerEntity("haxe_luanti:test", Mob);
	};
}
