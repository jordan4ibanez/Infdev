import entity.Mob;
import luantitypes.Core;

class Main {
	public static function main(): Void {
		Core.registerEntity("haxe_luanti:test", Mob);

		Core.registerOnJoinPlayer(() -> {
			// Core.requestShutdown();
		});
	};
}
