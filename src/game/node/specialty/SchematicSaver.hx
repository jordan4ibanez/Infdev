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
import src.engine.gui.FormspecLabel;
import src.engine.vector.Vec3;
import src.game.groups.NodeGroup;
import src.game.node.stone.StoneSound;

@:register("infdev:schematic_saver")
final class SchematicSaver extends NodeDefinition {
	var formspec: Formspec = new Formspec("schematic_saver_ui")
		.addElement("name_of_schematic", new FormspecLabel(0.1, 0.25, "This schematic is unnamed")
			.setStyle(new FormspecLabelStyle()
				.setFontSize(10)
			));

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

		Core.showFormspec(player.getPlayerName(), "infdev:testing", formspec.serialize());

		return super.onRightClick(pos, node, clicker, itemStack, pointedThing);
	}

	override function onReceiveFields(pos: Vec3, formName: String, fields: Table<Dynamic, Dynamic>, sender: Null<ObjectRefBase>) {
		super.onReceiveFields(pos, formName, fields, sender);

		untyped {
			print(formName);
			print(dump(fields));
		}
	}
}
