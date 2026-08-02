package src.game.node.specialty;

import lua.Table;
import src.engine.Core;
import src.engine.ItemStack;
import src.engine.NodeTable;
import src.engine.definition.NodeDefinition;
import src.engine.definition.basic.PointedThing;
import src.engine.entity.objectref.ObjectRefBase;
import src.engine.entity.objectref.ObjectRefPlayer;
import src.engine.gui.Formspec;
import src.engine.gui.FormspecButton;
import src.engine.gui.FormspecField;
import src.engine.gui.FormspecLabel;
import src.engine.metadata.NodeMetaRef;
import src.engine.vector.Vec3;
import src.game.groups.NodeGroup;
import src.game.node.stone.StoneSound;

@:register("infdev:schematic_saver")
final class SchematicSaver extends NodeDefinition {
	static final unnamedDefault = "This schematic is unnamed";

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

	public static var formspec: Formspec = new Formspec("schematic_saver_ui")
		.addElement("name_of_schematic", new FormspecLabel(0, 0.2, 10, 2, unnamedDefault)
			.setStyle(new FormspecLabelStyle()
				.setTextColor("white")
				.setHorizontalAlign(FormspecHorizontalAlignmentCenter)
				.setVerticalAlign(FormspecVerticalAlignmentTop)))
		.addElement("rename_field", new FormspecField(0.25, 4, 9.5, 1)
			.setStyle(new FormspecFieldStyle()
				.setHorizontalAlign(FormspecHorizontalAlignmentCenter)))
		.addElement("update_name", new FormspecButton(2.5, 6, 5, 1, "Update Name"))
		.addElement("save_schematic", new FormspecButton(2.5, 8, 5, 1, "Save Schematic"))
		.addElement("error_message", new FormspecLabel(0, 3, 10, 2, "")
			.setStyle(new FormspecLabelStyle()
				.setTextColor("red")
				.setFontSize(30)
				.setHorizontalAlign(FormspecHorizontalAlignmentCenter)
				.setVerticalAlign(FormspecVerticalAlignmentTop)));

	public function new() {
		super();

		this.description = "Schematic Saver";

		this.nodeGroups = [
			NodeGroupHandDiggable => BEDROCK
		];

		this.nodeSounds = StoneSound.get();

		this.tiles = ["default_cobble.png^[invert:rgb"];
	}

	override function onRightClick(pos: Vec3, node: NodeTable, clicker: Null<ObjectRefBase>, itemStack: ItemStack, pointedThing: Null<PointedThing>): ItemStack {
		// todo: put a static formspec thing in here. :)

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

		// ? This is literally updating the formspec and then making your player click it again.

		meta.setString("formspec", formspec.serialize(player));

		this.reClick(player, pointedThing);

		return itemStack;
	}

	override function onReceiveFields(pos: Vec3, doNotUse: String, fields: Table<String, String>, sender: Null<ObjectRefBase>) {
		if (sender == null || !sender.isPlayer()) {
			return;
		}

		untyped print(dump(fields));

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
			untyped print("setting: ", newName);

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
				triggerAlert("Schematic saved!", meta, player, pos, true);
				return;
				// formspecNameElement.setLabel("Name: " + schematicName);
				untyped print("save it!");
			}
		} else if (fields.quit == "true") {
			resetAlert();
		}
	}
}
