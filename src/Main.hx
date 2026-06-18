import lua.Lua;
import engine.entity.Mob;
import luantitypes.Core;

class Main {
	public static function main(): Void {
		Core.registerOnJoinPlayer((player, lastLogin) -> {
			// untyped {
			// 	trace(Global.dump(player.getMeta()));
			// }

			Core.requestShutdown();
		});

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
