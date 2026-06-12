package entity.helpers;

import haxe.ds.StringMap;
import luantitypes.Core;

@:noCompletion
final class PlayerHandling {
	static final playerLuaEntities = new StringMap<Player>();
	static final PLAYER_DATA_KEY = "PlayerSerializedData__HAXE__";

	static function __init__() {
		// trace("FIRING UP PLAYER HANDLING");

		// Player LuaEntity creation.
		Core.registerOnJoinPlayer((player, lastLogin) -> {
			player.getLuaEntity();
		});

		// Player LuaEntity destruction.
		Core.registerOnLeavePlayer((player, timedOut) -> {
			var ple = player.getLuaEntity();
			ple.onDeactivate(false);
			ModStorage.setString(player.getPlayerName() + PLAYER_DATA_KEY, ple.getStaticData());
		});

		// Player LuaEntity destruction.
		Core.registerOnShutDown(() -> {
			for (player in Core.getConnectedPlayers()) {
				var ple = player.getLuaEntity();
				ple.onDeactivate(false);
				ModStorage.setString(player.getPlayerName() + PLAYER_DATA_KEY, ple.getStaticData());
			}
		});

		// Player LuaEntity onStep.
		Core.registerGlobalStep((delta) -> {
			for (player in Core.getConnectedPlayers()) {
				player.getLuaEntity().onStep(delta);
			}
		});
	}

	private static function mimicLuaEntityConstruction(name: String, player: Player) {
		var playerObjectRef = Core.getPlayerByName(name);
		if (playerObjectRef == null) {
			throw "Player " + name + " is null";
		}
		player.object = playerObjectRef;

		var serialData: String = ModStorage.getString(name + PLAYER_DATA_KEY);
		var dtimeS = 0;

		player.onActivate(serialData, dtimeS);
	}

	@:allow(entity.objectref.ObjectRefPlayer)
	private static function getGlobalLuaEntity(name: String): Player {
		var thisLuaEntity = playerLuaEntities.get(name);

		if (thisLuaEntity == null) {
			thisLuaEntity = new Player();
			mimicLuaEntityConstruction(name, thisLuaEntity);
			playerLuaEntities.set(name, thisLuaEntity);
			// trace("created player luaentity", name);
			// } else {
			// trace("fetched player luaentity", name);
		}

		return thisLuaEntity;
	}
}
