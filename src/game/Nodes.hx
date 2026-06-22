package game;

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
		trace("flop");
	}

	// override function onReceiveFields(pos: EngineVector3, formName: String, fields: Dynamic, sender: Dynamic) {
	// 	super.onReceiveFields(pos, formName, fields, sender);
	// }
	// override function onRightClick(pos: EngineVector3, node: Dynamic, clicker: Null<ObjectRefBase>, itemStack: ItemStack, pointedThing: Null<PointedThing>): ItemStack {
	// 	trace("I have been clicked");
	// 	return super.onRightClick(pos, node, clicker, itemStack, pointedThing);
	// }
	// override function onSecondaryUse(itemstack: ItemStack, user: Null<ObjectRefBase>, pointedThing: PointedThing): Null<ItemStack> {
	// 	return super.onSecondaryUse(itemstack, user, pointedThing);
	// }
	// override function onTimer(pos: EngineVector3, elapsed: Float, node: Dynamic, timeout: Float): Bool {
	// 	return super.onTimer(pos, elapsed, node, timeout);
	// }
	// override function onUse(itemstack: ItemStack, user: Null<ObjectRefBase>, pointedThing: PointedThing): Null<ItemStack> {
	// 	return super.onUse(itemstack, user, pointedThing);
	// }
	// override function preserveMetadata(pos: EngineVector3, oldNode: Dynamic, oldMeta: Dynamic, drops: Array<ItemStack>) {
	// 	super.preserveMetadata(pos, oldNode, oldMeta, drops);
	// }

	override function onPlace(itemstack: ItemStack, placer: Null<ObjectRefBase>, pointedThing: PointedThing): Null<ItemStack> {
		trace("cool!");
		return super.onPlace(itemstack, placer, pointedThing);
	}
}
