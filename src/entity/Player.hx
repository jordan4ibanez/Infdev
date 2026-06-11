package entity;

import entity.objectref.ObjectRefPlayer;
import luantitypes.Macros;
import luantitypes.Core;
import haxe.ds.StringMap;
import entity.EntitySerialization;

final class Player {
	static final playerLuaEntities = new StringMap<Player>();
	static final PLAYER_DATA_KEY = "PlayerSerializedData";

	var object: ObjectRefPlayer = null;

	private function new() {}

	static function __init__() {
		Core.registerOnJoinPlayer((player, lastLogin) -> {
			player.getLuaEntity();
		});

		Core.registerOnLeavePlayer((player, timedOut) -> {
			var ple = player.getLuaEntity();
			ple.onDeactivate(false);
			ModStorage.setString(player.getPlayerName() + PLAYER_DATA_KEY, ple.getStaticData());
		});

		Core.registerOnShutDown(() -> {
			for (player in Core.getConnectedPlayers()) {
				var ple = player.getLuaEntity();
				ple.onDeactivate(false);
				ModStorage.setString(player.getPlayerName() + PLAYER_DATA_KEY, ple.getStaticData());
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

	public function onActivate(staticData: String, dtimeS: Float) {
		EntitySerialization.safeDeserialize(staticData, this, Macros.getCompileTimeClass());
		trace(this.object.getBreath());
	}

	function onDeactivate(removal: Bool) {
		trace("on_deactivate?");
	}

	function getStaticData(): String {
		return EntitySerialization.safeSerialize(this, Macros.getCompileTimeClass());
	}
}
