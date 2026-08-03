package src.game.node.specialty;

import lua.Table;
import src.engine.Core;
import src.engine.ItemStack;
import src.engine.NodeTable;
import src.engine.TimeStuff;
import src.engine.definition.NodeDefinition;
import src.engine.definition.basic.PointedThing;
import src.engine.entity.objectref.ObjectRefBase;
import src.engine.entity.objectref.ObjectRefPlayer;
import src.engine.gui.Formspec;
import src.engine.gui.FormspecButton;
import src.engine.gui.FormspecButtonExit;
import src.engine.gui.FormspecField;
import src.engine.gui.FormspecLabel;
import src.engine.metadata.NodeMetaRef;
import src.engine.vector.Vec3;
import src.game.groups.NodeGroup;
import src.game.node.stone.StoneSound;

// todo: put a load feature in here.
@:register("infdev:schematic_workshop_control_unit")
final class SchematicWorkshopControlUnit extends NodeDefinition {
	static inline final unnamedDefault = "This schematic is unnamed";

	public static inline final schematicSizeTag = "schematic_size";

	function triggerAlert(errorMessage: String, meta: NodeMetaRef, player: ObjectRefPlayer, pos: Vec3, ?successColor: Bool) {
		var newColor = (successColor ? "lime" : "red");

		(formspec.getElement("error_message") : FormspecLabel)
			.setLabel(errorMessage)
			.getStyle().setTextColor(newColor);
		meta.setString("formspec", formspec.serialize(player));

		// Then trigger a reclick.
		this.reClick(player, {
			type: PointedThingTypeNode,
			under: pos
		});
		// untyped print("triggered error");
	}

	function resetAlert() {
		(formspec.getElement("error_message") : FormspecLabel)
			.setLabel("");
		// untyped print("reset error");
	}

	public static var formspec: Formspec = new Formspec("schematic_workshop_ui")
		.addElement("name_of_schematic", new FormspecLabel(0, 0.2, 10, 2, unnamedDefault)
			.setStyle(new FormspecLabelStyle()
				.setTextColor("white")
				.setHorizontalAlign(FormspecHorizontalAlignmentCenter)
				.setVerticalAlign(FormspecVerticalAlignmentTop)))
		.addElement("size_display", new FormspecLabel(0, 1, 10, 2, "")
			.setStyle(new FormspecLabelStyle()
				.setTextColor("lightgray")
				.setHorizontalAlign(FormspecHorizontalAlignmentCenter)
				.setVerticalAlign(FormspecVerticalAlignmentTop)))
		.addElement("error_message", new FormspecLabel(0, 2, 10, 2, "")
			.setStyle(new FormspecLabelStyle()
				.setTextColor("red")
				.setFontSize(30)
				.setHorizontalAlign(FormspecHorizontalAlignmentCenter)
				.setVerticalAlign(FormspecVerticalAlignmentTop)))
		.addElement("rename_field", new FormspecField(0.25, 3, 9.5, 1)
			.setStyle(new FormspecFieldStyle()
				.setHorizontalAlign(FormspecHorizontalAlignmentCenter)))
		.addElement("update_name", new FormspecButton(2.5, 4.75, 5, 1, "Update Name")
			.setStyle(new FormspecButtonStyle()
				.setSound("lever")))
		.addElement("save_schematic", new FormspecButton(2.5, 6.5, 5, 1, "Save Schematic")
			.setStyle(new FormspecButtonStyle()
				.setSound("lever")))
		.addElement("exit_button", new FormspecButtonExit(2.5, 8.25, 5, 1, "Exit")
			.setStyle(new FormspecButtonStyle()
				.setSound("lever")));

	public function new() {
		super();

		this.description = "Schematic Workshop Control Unit";

		this.nodeGroups = [
			NodeGroupHandDiggable => BEDROCK
		];

		this.nodeSounds = StoneSound.get();

		this.lightSource = 14;

		this.tiles = [
			"infdev_schematic_workshop_side.png", "infdev_schematic_workshop_side.png",
			"infdev_schematic_workshop_side.png", "infdev_schematic_workshop_side.png",
			"infdev_schematic_workshop_side.png", "infdev_schematic_workshop_front.png",
		];
	}

	override function onRightClick(pos: Vec3, node: NodeTable, clicker: Null<ObjectRefBase>, itemStack: ItemStack, pointedThing: Null<PointedThing>): ItemStack {
		if (!clicker.isPlayer()) {
			return super.onRightClick(pos, node, clicker, itemStack, pointedThing);
		}

		var player: ObjectRefPlayer = cast clicker;

		// If the schematic has a name, use it, or else, declare it's unnamed.
		var meta = Core.getMeta(pos);
		var schematicName = meta.getString("schematic_name");
		var formspecNameElement = (formspec.getElement("name_of_schematic") : FormspecLabel);
		if (schematicName == "") {
			formspecNameElement.setLabel(unnamedDefault);
		} else {
			formspecNameElement.setLabel("Name: " + schematicName);
		}

		// Update the size of the formspec.

		var size: Null<Vec3> = Core.deserialize(meta.getString(schematicSizeTag));
		var formspecSizeElement = (formspec.getElement("size_display") : FormspecLabel);

		var sizeText = "Error: Size is null.";

		// This is slightly overbuilt.
		if (sizeText == null) {
			formspecSizeElement.getStyle().setTextColor("red");
			Core.log(LogLevelError, 'Error: Null schematic size at position: ${pos}');
		} else {
			formspecSizeElement.getStyle().setTextColor("lightgray");
			sizeText = 'Size: ( ${size.x}, ${size.y}, ${size.z} )';
		}

		formspecSizeElement.setLabel(sizeText);

		// ? This is literally updating the formspec and then making your player click it again.

		meta.setString("formspec", formspec.serialize(player));

		this.reClick(player, pointedThing);

		return itemStack;
	}

	override function onReceiveFields(pos: Vec3, doNotUse: String, fields: Table<String, String>, sender: Null<ObjectRefBase>) {
		if (sender == null || !sender.isPlayer()) {
			return;
		}

		// untyped print(dump(fields));

		var player: ObjectRefPlayer = cast sender;

		var meta = Core.getMeta(pos);

		// Update Name button.
		if (this.fieldsButtonEnterCheck(fields, "update_name", "rename_field")) {
			if (StringTools.trim(fields.rename_field) == "") {
				triggerAlert("Please input a name for your schematic.", meta, player, pos);
				return;
			} else if (StringTools.contains(fields.rename_field, " ")) {
				triggerAlert("Schematic name must not contain spaces.", meta, player, pos);
				return;
			}

			// Save the schematic name.
			var newName = StringTools.trim(fields.rename_field);
			// untyped print("setting: ", newName);

			meta.setString("schematic_name", newName);
			resetAlert();

			// Then trigger a reclick.
			this.reClick(player, {
				type: PointedThingTypeNode,
				under: pos
			});
		} else if (fields.save_schematic != null) {
			var schematicName = meta.getString("schematic_name");
			if (schematicName == "") {
				triggerAlert("Cannot save unnamed schematic.", meta, player, pos);
				return;
			} else {
				var size: Vec3 = Core.deserialize(meta.getString(schematicSizeTag));
				if (size == null) {
					Core.log(LogLevelError, 'Size of schematic workshop at position ${pos} was null. This workshop is broken.');
					return;
				}

				var p1 = pos.add(new Vec3(1, 1, 1));
				var p2 = pos.add(size);

				// todo: just add this to the core class already
				untyped __lua__("core.create_schematic({0}, {1}, {2}, {3}, {4})", p1, p2, null, Core.getWorldPath() + "/" + schematicName + ".mts", null);
				triggerAlert("Schematic saved to world folder!", meta, player, pos, true);
				Core.log(LogLevelAction, 'Saved schematic ${schematicName} to ${Core.getWorldPath}');

				Core.chatSendPlayer(player.getPlayerName(), 'Saved schematic ${schematicName} at time:${TimeStuff.getTime()}');
				return;
			}
		} else if (fields.quit == "true") {
			resetAlert();
			return;
		}
	}
}
