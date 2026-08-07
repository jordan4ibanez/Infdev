package src.game.entity.player;

import src.engine.entity.objectref.ObjectRefPlayer;

// This will actually save what tab you're on between logins.
final class PlayerInventoryMenu {
	var playerObject: ObjectRefPlayer;

	public function new(playerObject: ObjectRefPlayer) {
		this.playerObject = playerObject;
	}

	public function terminate(): Void {
		this.playerObject = null;
	}
}
