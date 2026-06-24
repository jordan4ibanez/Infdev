package game.nodes;

import lua.Table;
import engine.InvRef;
import engine.NodeTable;
import lua.Lua;
import luantitypes.Core;
import haxe.extern.EitherType;
import engine.definition.PointedThing;
import engine.entity.objectref.ObjectRefBase;
import engine.ItemStack;
import engine.definition.TouchInteractionSetting;
import engine.definition.sound.ItemSoundTable;
import engine.definition.graphics.WearBarColors;
import engine.definition.ToolCapabilities;
import engine.definition.basic.Pointabilities;
import engine.vector.EngineVector3;
import engine.definition.graphics.ItemImageDefinition.ItemImageDefinitionOrString;
import engine.definition.ItemDefinition;
import engine.definition.NodeDefinition;

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
