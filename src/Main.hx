import lua.Lua;
import entity.Mob;
import luantitypes.Core;

class Main {
	public static function main(): Void {
		// TODO: USE __init__ WITH A MACRO TO CREATE A CUSTOM ENTITY REGISTRATION!
		Core.registerEntity("haxe_luanti:test", Mob);

		// Core.registerOnJoinPlayer((player, lastLogin) -> {
		// untyped {
		// 	trace(Global.dump(player.getMeta()));
		// }

		// var x = player.getLuaEntity();

		// trace(x);

		// Core.requestShutdown();
		// });

		// Core.registerGlobalStep((delta) -> {
		// 	for (player in Core.getConnectedPlayers()) {
		// 		// trace(player.getBreath());
		// 		trace("GLOBAL LOOP");
		// 		player.getLuaEntity();
		// 	}

		// 	// trace(delta);
		// });
	};
}
