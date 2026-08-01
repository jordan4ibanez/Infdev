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
import src.engine.vector.Vec3;
import src.game.groups.NodeGroup;
import src.game.node.stone.StoneSound;

@:register("infdev:schematic_saver")
final class SchematicSaver extends NodeDefinition {
	static final unnamedDefault = "This schematic is unnamed";

	public static var formspec: Formspec = new Formspec("schematic_saver_ui")
		.addElement("name_of_schematic", new FormspecLabel(0, 0.2, 10, 2, unnamedDefault)
			.setStyle(new FormspecLabelStyle()
				.setFontSize(40)
				.setHorizontalAlign(FormspecHorizontalAlignmentCenter)
				.setVerticalAlign(FormspecVerticalAlignmentTop)))
		.addElement("rename_field", new FormspecField(0.25, 4, 9.5, 1)
			.setStyle(new FormspecFieldStyle()
				.setFontSize(40)
				.setHorizontalAlign(FormspecHorizontalAlignmentCenter)))
		.addElement("update_name", new FormspecButton(3, 6, 4, 1, "Update Name")
			.setStyle(new FormspecButtonStyle()
				.setFontSize(40)))
		.addElement("error_message", new FormspecLabel(0, 0, 10, 2, "testing")
			.setStyle(new FormspecLabelStyle()
				.setFontSize(40)));

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
		var schematicName = Core.getMeta(pos).getString("schematic_name");
		var formspecNameElement = (cast formspec.getElement("name_of_schematic") : FormspecLabel);
		if (schematicName == "") {
			formspecNameElement.setLabel(unnamedDefault);
		} else {
			formspecNameElement.setLabel("Name: " + schematicName);
		}

		// ? This is literally updating the formspec and then making your player click it again.

		// Core.showFormspec(player.getPlayerName(), "infdev:testing", output);
		Core.getMeta(pos).setString("formspec", formspec.serialize(player));

		this.reClick(player, pointedThing);

		return itemStack;
	}

	override function onReceiveFields(pos: Vec3, doNotUse: String, fields: Table<String, String>, sender: Null<ObjectRefBase>) {
		untyped {
			print(formName); // It doesn't have one
			print(dump(fields));
		}
	}
}
