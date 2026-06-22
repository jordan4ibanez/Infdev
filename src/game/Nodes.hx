package game;

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
		Lua.print("I am created");

		this.nodeColor = "blue";
	}

	override function onConstruct(pos: EngineVector3) {
		super.onConstruct(pos);

		var meta = Core.getMeta(pos);

		meta.setString("formspec",
			"size[8,8]"
			+ "button[2,2;4,1;btn_name;Click Me]"
			+ "list[context;main;0,0;8,4;]"
			+ "list[current_player;main;0,5;8,4;]");
	}

	override function onDestruct(pos: EngineVector3) {
		trace("ondestruct");
		super.onDestruct(pos);
	}

	override function afterDestruct(pos: EngineVector3, oldNode: Dynamic) {
		trace("after destruct");
		trace(oldNode);
		super.afterDestruct(pos, oldNode);
	}

	override function onPunch(pos: EngineVector3, node: Dynamic, puncher: Null<ObjectRefBase>, pointedThing: PointedThing) {
		// super.onPunch(pos, node, puncher, pointedThing);
		// Core.removeNode(pos);
		var timer = Core.getNodeTimer(pos);

		timer.start(0.5);
	}

	override function onTimer(pos: EngineVector3, elapsed: Float, node: NodeTable, timeout: Float): Bool {
		trace("I have been on timered", timeout);

		return super.onTimer(pos, elapsed, node, timeout);
	}

	override function onPlace(itemstack: ItemStack, placer: Null<ObjectRefBase>, pointedThing: PointedThing): Null<ItemStack> {
		trace("cool!");
		return super.onPlace(itemstack, placer, pointedThing);
	}
}
