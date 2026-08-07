package src.game.entity.player;

import src.engine.entity.objectref.ObjectRefPlayer;
import src.engine.gui.Formspec;

// This will actually save what tab you're on between logins.
final class PlayerInventoryFormspec {
	var playerObject: ObjectRefPlayer;

	// This is REALLY, REALLY memory inefficient but I can't run a function when
	// the player opens their inventory.
	var formspec: Formspec = new Formspec("player_inventory");

	public function new(playerObject: ObjectRefPlayer) {
		this.playerObject = playerObject;
	}

	public function terminate(): Void {
		this.playerObject = null;
	}

	public function serialize(): String {
		return formspec.serialize(this.playerObject);
	}
}
