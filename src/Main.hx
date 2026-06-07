import entity.Mob;
import luanti_types.Core;

class Main {
	public static function main(): Void {
		Core.registerEntity("haxe_luanti:test", Mob);

		Core.registerOnJoinPlayer(() -> {
			// Core.requestShutdown();
		});
	};
}
