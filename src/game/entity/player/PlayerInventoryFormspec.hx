package src.game.entity.player;

import lua.Lua;
import lua.Table;
import src.engine.Core;
import src.engine.definition.sound.SimpleSoundSpecTable;
import src.engine.definition.sound.SoundParameterTable;
import src.engine.entity.objectref.ObjectRefPlayer;
import src.engine.gui.Formspec;
import src.engine.gui.FormspecDropDown;
import src.engine.gui.FormspecLabel;
import src.engine.gui.FormspecList;
import src.engine.gui.FormspecTabHeader;

// This will actually save what tab you're on between logins.
final class PlayerInventoryFormspec {
	var player: ObjectRefPlayer;

	static inline final navigationBarName = "navigation";

	// This can't be bolted in and it has to be hacked on.
	// This is the least bad place to put this.
	static function deployPlayerInventoryMovementSounds(): Void {
		Core.registerOnPlayerInventoryAction((player, action, inventory, inventoryInfo) -> {
			// Something was hacked into the game.
			if (!player.isPlayer()) {
				return;
			}

			// Player threw an item out of their inventory.
			// Todo: Maybe a special sound for this?
			if (inventoryInfo.to_list == null) {
				return;
			}

			Core.soundPlay(
				new SimpleSoundSpecTable("infdev_inventory_action"),
				new SoundParameterTable()
					.setToPlayer(player.getPlayerName())
					.setGain(0.25)
			);
		});
	}

	static function __init__() {
		deployPlayerInventoryMovementSounds();
	}

	static final tabs: Array<TabInfo> = [
		{
			name: "inventory",
			display: "Inventory"
		},
		{
			name: "equipment",
			display: "Equipment"
		},
		{
			name: "skills",
			display: "  Skills  "
		},
		{
			name: "effects",
			display: " Effects "
		},
		{
			name: "bartering",
			display: "Bartering"
		},
		{
			name: "settings",
			display: "Settings"
		},
		{
			name: "credits",
			display: "Credits"
		},
	];

	// This is REALLY, REALLY memory inefficient but I can't run a function when
	// the player opens their inventory.
	// todo: The main inventory list will need to expand sideways when a player levels up.
	var formspec: Formspec = (() -> {
		var f = new Formspec("", "inventory");
		// ? Root elements.
		f.addRootElement(navigationBarName, new FormspecTabHeader(
			0.09, 0.625,
			9.82, 0.5,
			true,
			1,
			tabs)
			.setStyle(new FormspecTabHeaderStyle()
				.setSound("infdev_interface_button")
				.setTextColor("#FFFF00"))
			.setAction(tabNavigationAction));
		var hotbarPosY = 5.8;
		var invPosY = 6.655;
		// todo: this should check the player for a level to decide how wide it is.
		// todo: that's gonna be complicated
		//
		// ? Inventory page.
		// Hot bar.
		f.addElement(tabs[0].name, "hot_bar_inv", new FormspecList("current_player", "main", 0.09, hotbarPosY, 12, 1));
		// Rest of inventory.
		f.addElement(tabs[0].name, "main_inventory_inv", new FormspecList("current_player", "main", 0.09, invPosY, 12, 7, 12));
		//
		// ? Equipment page.
		// Hot bar.
		f.addElement(tabs[1].name, "hot_bar_effects", new FormspecList("current_player", "main", 0.09, hotbarPosY, 12, 1));
		// Rest of inventory.
		f.addElement(tabs[1].name, "main_inventory_effects", new FormspecList("current_player", "main", 0.09, invPosY, 12, 7, 12));
		// ? Skills page.
		f.addElement(tabs[2].name, "todo_skills", new FormspecLabel(0, 3, 0, 0, "Todo"));
		// ? Effects page.
		f.addElement(tabs[3].name, "todo_effects", new FormspecLabel(0, 3, 0, 0, "Todo"));
		// ? Bartering Hall page.
		f.addElement(tabs[4].name, "todo_barting", new FormspecLabel(0, 3, 0, 0, "Todo"));
		// ? Game Settings page.
		f.addElement(tabs[5].name, "todo_settings", new FormspecLabel(0, 3, 0, 0, "Todo"));
		f.addElement(tabs[5].name, "sample_setting", new FormspecDropDown(1, 2, 3, 0.5, 1, "test", "a thing", "another")
			.setStyle(new FormspecDropDownStyle().setSound("infdev_interface_button")));
		// ? Credits page.
		f.addElement(tabs[6].name, "todo_credits", new FormspecLabel(0, 3, 0, 0, "Todo"));
		return f;
	})();

	public function new(player: ObjectRefPlayer) {
		this.player = player;
		this.formspec.setPlayer(player);
	}

	public function whenPlayerLeaves(): Void {

	}

	// This is for when a player clicks the tabs at the top of their inventory.
	static function tabNavigationAction(thisFormspec: Formspec, thisElement: FormspecElement, fields: Table<String, String>) {
		var page = Lua.tonumber(fields[cast navigationBarName]);
		(cast thisElement : FormspecTabHeader).setCurrentTab(page);
		thisFormspec.goToPage(tabs[page - 1].name);
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
