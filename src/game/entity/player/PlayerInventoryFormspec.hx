package src.game.entity.player;

import lua.Table;
import src.engine.Core;
import src.engine.ModStorage;
import src.engine.compilercode.LuaLoop;
import src.engine.definition.sound.SimpleSoundSpecTable;
import src.engine.definition.sound.SoundParameterTable;
import src.engine.entity.objectref.ObjectRefPlayer;
import src.engine.gui.CheckBox;
import src.engine.gui.DropDown;
import src.engine.gui.Gui;
import src.engine.gui.Label;
import src.engine.gui.List;
import src.engine.gui.TabHeader;
import src.engine.gui.TextArea;

// This will actually save what tab you're on between logins.
final class PlayerInventoryFormspec {
	var player: ObjectRefPlayer;
	var playerName: String;

	static inline final navigationBarName = "navigation";

	// Play a sound to the player when they move things around in the inventory.
	// This can't be bolted in and it has to be hacked on.
	// This is the least bad place to put this.
	//
	// This logs the if the sound was played this server tick.
	// This is the key to stop swapping items from playing a sound twice on the same frame.
	//
	static var playerTimerMap: Map<String, Bool> = new Map();

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

			final name = player.getPlayerName();
			final alreadyPlayed = playerTimerMap.get(name);
			if (alreadyPlayed == null) {
				throw 'Null inventory hackjob sound tick bool in map for player ${name}';
			}

			// Don't play more than one sound at a time.
			if (alreadyPlayed) {
				return;
			}

			Core.soundPlay(
				new SimpleSoundSpecTable("infdev_inventory_action"),
				// todo: make this an option in the sounds menu.
				new SoundParameterTable()
					.setToPlayer(player.getPlayerName())
					.setGain(0.5)
			);

			playerTimerMap.set(name, true);
		});
	}

	static function __init__() {
		deployPlayerInventoryMovementSounds();
	}

	// End spaghetti.
	//
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
			name: "notes",
			display: "Notes"
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
	var formspec: Gui;

	public function new(player: ObjectRefPlayer) {
		this.player = player;
		this.playerName = this.player.getPlayerName();
		this.formspec = this.deployGUI();
		this.formspec.setPlayer(player);
		playerTimerMap.set(player.getPlayerName(), false);

		// ! Never remove this. The engine formspec code for the inventory is a mess and needs this to hold the data.
		Core.after(0, () -> {
			this.player.setInventoryFormspec(this.serialize());
		});
		this.formspec.doActionOnClose((thisFormspec) -> {
			this.player.setInventoryFormspec(this.serialize());
		});
		// ! End.
	}

	function deployGUI(): Gui {
		var f = new Gui("", "inventory");
		// ? Root elements.
		f.addRootElement(navigationBarName, new TabHeader(
			null,
			true,
			navigationBarName,
			0.09, 0.125,
			1.1, 0.5, 0.01,
			true,
			1,
			tabs)
			.setStyles(
				new TabHeaderStyle()
					.setSound("infdev_interface_button")
					.setTextColor("#FFFF00")
					.setFontSize(12),
				new TabHeaderStyle()
					.setFontSize(12)
					.setTextColor("red")
					.setBackgroundColor("gray"))
			.setAction(tabNavigationAction));
		var hotbarPosY = 5.8;
		var invPosY = 6.655;
		// todo: this should check the player for a level to decide how wide it is.
		// todo: that's gonna be complicated
		//
		// ? Inventory page.
		// Hot bar.
		f.addElement(tabs[0].name, "hot_bar_inv", new List("current_player", "main", 0.09, hotbarPosY, 12, 1));
		// Rest of inventory.
		f.addElement(tabs[0].name, "main_inventory_inv", new List("current_player", "main", 0.09, invPosY, 12, 7, 12));
		//
		// ? Equipment page.
		// Hot bar.
		f.addElement(tabs[1].name, "hot_bar_effects", new List("current_player", "main", 0.09, hotbarPosY, 12, 1));
		// Rest of inventory.
		f.addElement(tabs[1].name, "main_inventory_effects", new List("current_player", "main", 0.09, invPosY, 12, 7, 12));
		// ? Skills page.
		f.addElement(tabs[2].name, "todo_skills", new Label(0, 3, 0, 0, "Todo"));
		// ? Effects page.
		f.addElement(tabs[3].name, "todo_effects", new Label(0, 3, 0, 0, "Todo"));
		// ? Bartering Hall page.
		f.addElement(tabs[4].name, "todo_barting", new Label(0, 3, 0, 0, "Todo"));
		// ? Notes page.
		// todo: this needs a save button.
		f.addElement(tabs[5].name, "note_taking_area", new TextArea(0.09, 0.75, 9.82, 8.5, "", this.loadNotesPage())
			.setStyle(new TextAreaStyle()
				.setFontSize(14)));
		// ? Game Settings page.
		f.addElement(tabs[6].name, "todo_settings", new Label(0, 3, 0, 0, "Todo"));
		f.addElement(tabs[6].name, "sample_setting", new DropDown(1, 2, 3, 0.5, 1, "test", "a thing", "another")
			.setStyle(new DropDownStyle().setSound("infdev_interface_button")));
		f.addElement(tabs[6].name, "sample_checkbox", new CheckBox(2, 3, "check me", false)
			.setStyle(new CheckBoxStyle().setSound("infdev_interface_checkbox")));
		// ? Credits page.
		f.addElement(tabs[7].name, "todo_credits", new Label(0, 3, 0, 0, "Todo"));
		return f;
	}

	function loadNotesPage(): String {
		// Returns "" if it's not there so this is perfect!
		return ModStorage.getString(this.player.getPlayerName() + "_inventory_notes_page");
	}

	function saveNotesPage(): Void {
		var noteTextAreaElement: TextArea = this.formspec.getElement(tabs[5].name, "note_taking_area");
		var text = noteTextAreaElement.getCurrentText();
		ModStorage.setString(this.player.getPlayerName() + "_inventory_notes_page", text);
	}

	public function terminate(): Void {
		this.saveNotesPage();
		playerTimerMap.remove(this.player.getPlayerName());
	}

	public function doPlayerInventorySoundReset() {
		playerTimerMap.set(this.player.getPlayerName(), false);
	}

	// This is for when a player clicks the tabs at the top of their inventory.
	static function tabNavigationAction(thisFormspec: Gui, thisElement: GuiElement, fields: Table<String, String>) {
		final nameFilterRegex = '^${navigationBarName}_%d+$';
		final nameProcessingFilter = '^${navigationBarName}_';

		// todo: turn this into a function somehow.
		LuaLoop.nativePairs(k, v, fields, {
			if (untyped __lua__('string.match({0}, {1})', k, nameFilterRegex)) {
				var indexString = untyped __lua__('string.gsub({0}, {1}, "")', k, nameProcessingFilter);
				var index = untyped __lua__('tonumber({0})', indexString);
				// For the tabs to display selection properly, it must go in this order.
				var tabNavigatorElement = (cast thisFormspec.getRootElement(navigationBarName) : TabHeader);
				// Stop players from spamming tab clicks.
				if (tabNavigatorElement.getCurrentTab() == index) {
					return;
				}
				tabNavigatorElement.setCurrentTab(index);
				thisFormspec.goToPage(tabs[index].name);
				LuaLoop.breakLoop();
			}
		});
	}

	public function serialize(): String {
		return formspec.serialize();
	}

	public function process(fields: Table<String, String>): Void {
		untyped print("remove the player thing from formspec");
	}
}
