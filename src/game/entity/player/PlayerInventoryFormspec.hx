package src.game.entity.player;

import src.engine.entity.objectref.ObjectRefPlayer;

// This will actually save what tab you're on between logins.
final class PlayerInventoryFormspec {
	var playerObject: ObjectRefPlayer;

	static var formspec: Formspec = new Formspec();

	public function new(playerObject: ObjectRefPlayer) {
		this.playerObject = playerObject;
	}

	public function terminate(): Void {
		this.playerObject = null;
	}

	public function serialize(): String {
		return formspec;
	}
}
