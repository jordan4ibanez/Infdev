package src.game.item;

import src.engine.definition.ToolDefinition;
import src.engine.definition.PointedThing;
import src.engine.Core.Global;
import lua.Lua;
import src.engine.definition.ToolCapabilities;
import src.engine.definition.graphics.WearBarColors;
import src.engine.vector.Vec3;
import src.engine.ItemStack;
import src.engine.entity.objectref.ObjectRefBase;
import src.engine.NodeTable;
import src.engine.definition.ItemDefinition;

@:register("infdev:stick")
final class Stick extends ItemDefinition {
	public function new() {
		super();
	}
}
