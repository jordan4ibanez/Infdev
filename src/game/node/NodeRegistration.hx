package src.game.node;

import lua.Table;
import src.engine.InvRef;
import src.engine.NodeTable;
import lua.Lua;
import luantitypes.Core;
import haxe.extern.EitherType;
import src.engine.definition.PointedThing;
import src.engine.entity.objectref.ObjectRefBase;
import src.engine.ItemStack;
import src.engine.definition.TouchInteractionSetting;
import src.engine.definition.sound.ItemSoundTable;
import src.engine.definition.graphics.WearBarColors;
import src.engine.definition.ToolCapabilities;
import src.engine.definition.basic.Pointabilities;
import src.engine.vector.EngineVector3;
import src.engine.definition.graphics.ItemImageDefinition.ItemImageDefinitionOrString;
import src.engine.definition.ItemDefinition;
import src.engine.definition.NodeDefinition;

@:register("infdev:dirt")
final class Dirt extends NodeDefinition {
	public function new() {
		super();
		this.nodeColor = "blue";
		this.groups = {
			dirt: 1
		};
	}
}
