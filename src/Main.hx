import entity.Mob;
import luanti_types.Core;

class Main {
	public static function main() {
		Core.registerEntity("haxe_luanti:test", Mob);

		Core.registerOnJoinPlayer(() -> {
			// Core.requestShutdown();
		});
	};
}
