package src.game.node.specialty;

import lua.Table;
import src.engine.definition.NodeDefinition;
import src.engine.entity.objectref.ObjectRefBase;
import src.engine.vector.Vec3;
import src.game.groups.NodeGroup;
import src.game.node.stone.StoneSound;

@:register("infdev:schematic_saver")
final class SchematicSaver extends NodeDefinition {
	public function new() {
		super();

		this.description = "Schematic Saver";

		this.nodeGroups = [
			NodeGroupHandDiggable => BEDROCK
		];

		this.nodeSounds = StoneSound.get();

		this.tiles = ["default_cobble.png^[invert:rgb"];
	}

	override function onReceiveFields(pos: Vec3, formName: String, fields: Table<Dynamic, Dynamic>, sender: Null<ObjectRefBase>) {
		super.onReceiveFields(pos, formName, fields, sender);

		untyped {
			print(formName);
			print(dump(fields));
		}
	}
}
