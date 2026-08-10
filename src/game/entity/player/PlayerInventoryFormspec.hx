package src.game.entity.player;

import lua.Table;
import src.engine.entity.objectref.ObjectRefPlayer;
import src.engine.gui.Formspec;
import src.engine.gui.FormspecList;
import src.engine.gui.FormspecTabHeader;

// This will actually save what tab you're on between logins.
final class PlayerInventoryFormspec {
	var player: ObjectRefPlayer;

	// This is REALLY, REALLY memory inefficient but I can't run a function when
	// the player opens their inventory.
	// todo: The main inventory list will need to expand sideways when a player levels up.
	var formspec: Formspec = (() -> {
		var f = new Formspec("", "inventory");
		f.addRootElement("navigation", new FormspecTabHeader(
			0.09, 0.6,
			9.82, 0.5,
			true,
			"Inventory",
			"Equipment",
			"  Skills  ",
			" Effects ",
			"Bartering",
			"Credits"));
		// Hot bar.
		f.addElement("inventory", "hot_bar", new FormspecList("current_player", "main", 0.09, 5.8, 12, 1));
		// Rest of inventory.
		f.addElement("inventory", "main_inventory", new FormspecList("current_player", "main", 0.09, 6.7, 12, 7, 12));
		return f;
	})();

	public function new(player: ObjectRefPlayer) {
		this.player = player;
		this.formspec.setPlayer(player);
	}

	public function serialize(): String {
		return formspec.serialize();
	}

	public function updateScaling(): Void {
		player.setInventoryFormspec(this.serialize());
	}

	public function process(fields: Table<String, String>): Void {
		untyped print("remove the player thing from formspec");
	}
}
