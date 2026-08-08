package src.game.entity.player;

import lua.Table;
import src.engine.entity.objectref.ObjectRefPlayer;
import src.engine.gui.Formspec;
import src.engine.gui.FormspecList;

// This will actually save what tab you're on between logins.
final class PlayerInventoryFormspec {
	var playerObject: ObjectRefPlayer;

	// This is REALLY, REALLY memory inefficient but I can't run a function when
	// the player opens their inventory.
	// todo: The main inentory will need to expand sideways when a player levels up.
	var formspec: Formspec = new Formspec("player_inventory")
		.addElement("hot_bar", new FormspecList("current_player", "main", 0.09, 5.7, 12, 1)) // Hot bar.
		.addElement("main_inventory", new FormspecList("current_player", "main", 0.09, 6.6304, 12, 7, 12)); // Rest of inventory.

	public function new(playerObject: ObjectRefPlayer) {
		this.playerObject = playerObject;
	}

	public function terminate(): Void {
		this.playerObject = null;
	}

	public function serialize(): String {
		return formspec.serialize(this.playerObject);
	}

	public function updateScaling(): Void {
		playerObject.setInventoryFormspec(this.serialize());
	}

	public function process(fields: Table<String, String>): Void {
		untyped print(dump(fields));
	}
}
