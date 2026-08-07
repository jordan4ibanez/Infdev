package src.game.entity.player;

import src.engine.entity.objectref.ObjectRefPlayer;

final class PlayerInventoryMenu {
	var playerObject: ObjectRefPlayer;

	public function new(playerObject: ObjectRefPlayer) {
		this.playerObject = playerObject;
	}

	public function terminate(): Void {
		this.playerObject = null;
	}
}
