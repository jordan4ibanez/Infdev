package src.game.entity.player;

import lua.Table;
import src.engine.entity.objectref.ObjectRefPlayer;
import src.engine.gui.Formspec;
import src.engine.gui.FormspecButton;
import src.engine.gui.FormspecField;
import src.engine.gui.FormspecLabel;
import src.engine.gui.FormspecList;

// This will actually save what tab you're on between logins.
final class PlayerInventoryFormspec {
	var player: ObjectRefPlayer;

	// This is REALLY, REALLY memory inefficient but I can't run a function when
	// the player opens their inventory.
	// todo: The main inentory will need to expand sideways when a player levels up.
	var formspec: Formspec = new Formspec("", "inventory")
		.addElement("inventory", "hot_bar", new FormspecList("current_player", "main", 0.09, 5.7, 12, 1)) // Hot bar.
		.addElement("inventory", "main_inventory", new FormspecList("current_player", "main", 0.09, 6.6304, 12, 7, 12)) // Rest of inventory.
		.doActionOnAnyUpdate((_) -> {
			untyped print("hello");
		})
		.doActionOnClose(() -> {
			untyped print("peace");
		})
		.addElement("inventory", "test_button", new FormspecButton(0, 0, 2, 2, "button")
			.setAction((fields) -> {
				untyped print("this cool test button was pressed!");
			}))
		.addElement("inventory", "test_field", new FormspecField(2, 0, 4, 1))
		.addElement("inventory", "another_field", new FormspecField(2, 2, 4, 1))
		.addElement("inventory", "data_test", new FormspecLabel(0, 0, 0, 0, "good day"));

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
