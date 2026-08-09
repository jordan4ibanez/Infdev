package src.engine.entity.helpers;

import haxe.ds.StringMap;
import src.engine.Core;
import src.engine.gui.Formspec;
import src.game.entity.player.Player;

@:noCompletion
final class PlayerHandling {
	static final playerLuaEntities = new StringMap<Player>();
	static final PLAYER_DATA_KEY = "PlayerSerializedData__HAXE__";

	static function __init__() {
		loadUpHandler();
	}

	static function loadUpHandler() {
		// trace("FIRING UP PLAYER HANDLING");

		// Player LuaEntity creation.
		Core.registerOnJoinPlayer((player, lastLogin) -> {
			Formspec.addPlayerToMasterFormspecContainer(player);
			final name = player.getPlayerName();
			var playerLuaEntity = getGlobalLuaEntity(name);
			mimicLuaEntityConstruction(name, playerLuaEntity);
		});

		// Player LuaEntity destruction.
		Core.registerOnLeavePlayer((player, timedOut) -> {
			Formspec.removePlayerFromMasterFormspecContainer(player);
			var ple = player.getPlayerLuaEntity();
			ple.onDeactivate(false);
			ModStorage.setString(player.getPlayerName() + PLAYER_DATA_KEY, ple.getStaticData());
			playerLuaEntities.remove(player.getPlayerName());
		});

		// Player LuaEntity destruction.
		Core.registerOnShutDown(() -> {
			for (player in Core.getConnectedPlayers()) {
				var ple = player.getPlayerLuaEntity();
				ple.onDeactivate(false);
				ModStorage.setString(player.getPlayerName() + PLAYER_DATA_KEY, ple.getStaticData());
				playerLuaEntities.remove(player.getPlayerName());
			}
		});

		// Player LuaEntity onNewPlayer.
		Core.registerOnNewPlayer((player) -> {
			player.getPlayerLuaEntity().onNewPlayer();
		});

		// Player LuaEntity onStep.
		Core.registerGlobalStep((delta) -> {
			for (player in Core.getConnectedPlayers()) {
				player.getPlayerLuaEntity().onStep(delta);
			}
		});

		// Player LuaEntity onPunch.
		Core.registerOnPunchPlayer((player, hitter, timeFromLastPunch, toolCapabilities, dir, damage) -> {
			return player.getPlayerLuaEntity().onPunch(hitter, timeFromLastPunch, toolCapabilities, dir, damage);
		});

		Core.registerOnRightClickPlayer((player, clicker) -> {
			player.getPlayerLuaEntity().onRightClick(clicker);
		});

		Core.registeronPlayerHPChange((player, hpChange, reason) -> {
			return player.getPlayerLuaEntity().onHPChange(hpChange, reason);
		}, true);

		Core.registerOnDiePlayer((player, reason) -> {
			player.getPlayerLuaEntity().onDeath(reason);
		});

		Core.registerOnRespawnPlayer((player) -> {
			return player.getPlayerLuaEntity().onRespawn();
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

	@:allow(src.engine.entity.objectref.ObjectRefPlayer)
	private static function getGlobalLuaEntity(name: String): Player {
		var thisLuaEntity = playerLuaEntities.get(name);

		if (thisLuaEntity == null) {
			thisLuaEntity = new Player();
			playerLuaEntities.set(name, thisLuaEntity);
			// trace("created player luaentity", name);
			// } else {
			// trace("fetched player luaentity", name);
		}
		return thisLuaEntity;
	}
}
