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
import src.engine.gui.FormspecField;
import src.engine.gui.FormspecLabel;
import src.engine.vector.Vec3;
import src.game.groups.NodeGroup;
import src.game.node.stone.StoneSound;

@:register("infdev:schematic_saver")
final class SchematicSaver extends NodeDefinition {
	public static var formspec: Formspec = new Formspec("schematic_saver_ui")
		.addElement("name_of_schematic", new FormspecLabel(0, 0.2, 10, 2, "This schematic is unnamed")
			.setStyle(new FormspecLabelStyle()
				.setFontSize(40)
				.setHorizontalAlign(FormspecHorizontalAlignmentCenter)
				.setVerticalAlign(FormspecVerticalAlignmentTop)))
		.addElement("rename_field", new FormspecField(0.25, 4, 9.5, 1)
			.setStyle(new FormspecFieldStyle()
				.setFontSize(40)
				.setHorizontalAlign(FormspecHorizontalAlignmentCenter)));

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

		// todo: get node metadata schematic_name
		(cast formspec.getElement("name_of_schematic") : FormspecLabel).setLabel("test");

		// todo: implement buttons.
		var output = formspec.serialize(player);
		output += 'button[3,6;4,1;update_name;Update Name]';

		// ? This is literally updating the formspec and then making your player click it again.

		// Core.showFormspec(player.getPlayerName(), "infdev:testing", output);
		Core.getMeta(pos).setString("formspec", output);

		this.reClick(player, pointedThing);

		return itemStack;
	}

	override function onReceiveFields(pos: Vec3, formName: String, fields: Table<Dynamic, Dynamic>, sender: Null<ObjectRefBase>) {
		untyped {
			print(formName); // It doesn't have one
			print(dump(fields));
		}
	}
}
