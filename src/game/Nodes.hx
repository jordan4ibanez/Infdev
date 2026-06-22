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
		super.onDestruct(pos);
	}

	override function afterDestruct(pos: EngineVector3, oldNode: Dynamic) {
		trace(oldNode);
		super.afterDestruct(pos, oldNode);
	}

	override function onFlood(pos: EngineVector3, oldNode: Dynamic, newNode: Dynamic): Bool {
		return super.onFlood(pos, oldNode, newNode);
	}

	override function afterDigNode(pos: EngineVector3, oldNode: Dynamic, oldMetaData: Dynamic, digger: Null<ObjectRefBase>) {
		super.afterDigNode(pos, oldNode, oldMetaData, digger);
	}

	override function afterPlaceNode(pos: EngineVector3, placer: Null<ObjectRefBase>, itemStack: ItemStack, pointedThing: PointedThing): Bool {
		return super.afterPlaceNode(pos, placer, itemStack, pointedThing);
	}

	override function afterUse(itemstack: ItemStack, user: Null<ObjectRefBase>, node: Dynamic, digparams: Dynamic): Null<ItemStack> {
		return super.afterUse(itemstack, user, node, digparams);
	}

	override function allowMetadataInventoryMove(pos: EngineVector3, fromList: String, fromIndex: Int, toList: String, toIndex: Int, count: Int, player: Null<ObjectRefBase>): Int {
		return super.allowMetadataInventoryMove(pos, fromList, fromIndex, toList, toIndex, count, player);
	}

	override function allowMetadataInventoryPut(pos: EngineVector3, listName: String, index: Int, stack: ItemStack, player: Null<ObjectRefBase>): Int {
		return super.allowMetadataInventoryPut(pos, listName, index, stack, player);
	}

	override function allowMetadataInventoryTake(pos: EngineVector3, listName: String, index: Int, stack: ItemStack, player: Null<ObjectRefBase>): Int {
		return super.allowMetadataInventoryTake(pos, listName, index, stack, player);
	}

	override function canDig(pos: EngineVector3, player: Null<ObjectRefBase>): Bool {
		return super.canDig(pos, player);
	}

	override function onBlast(pos: EngineVector3, intensity: Float) {
		super.onBlast(pos, intensity);
	}

	override function onDig(pos: EngineVector3, node: Dynamic, digger: Null<ObjectRefBase>): Bool {
		return super.onDig(pos, node, digger);
	}

	override function onDrop(itemstack: ItemStack, dropper: Null<ObjectRefBase>, pos: EngineVector3): Null<ItemStack> {
		return super.onDrop(itemstack, dropper, pos);
	}

	override function onMetadataInventoryMove(pos: EngineVector3, fromList: String, fromIndex: Int, toList: String, toIndex: Int, count: Int, player: Null<ObjectRefBase>) {
		super.onMetadataInventoryMove(pos, fromList, fromIndex, toList, toIndex, count, player);
	}

	override function onMetadataInventoryPut(pos: EngineVector3, listName: String, index: Int, stack: ItemStack, player: Null<ObjectRefBase>) {
		super.onMetadataInventoryPut(pos, listName, index, stack, player);
	}

	override function onMetadataInventoryTake(pos: EngineVector3, listName: String, index: Int, stack: ItemStack, player: Null<ObjectRefBase>) {
		super.onMetadataInventoryTake(pos, listName, index, stack, player);
	}

	override function onPickup(itemstack: ItemStack, picker: Null<ObjectRefBase>, pointedThing: PointedThing, timeFromLastPunch: Float): Null<ItemStack> {
		return super.onPickup(itemstack, picker, pointedThing, timeFromLastPunch);
	}

	override function onPunch(pos: EngineVector3, node: Dynamic, puncher: Null<ObjectRefBase>, pointedThing: PointedThing) {
		super.onPunch(pos, node, puncher, pointedThing);
	}

	override function onReceiveFields(pos: EngineVector3, formName: String, fields: Dynamic, sender: Dynamic) {
		super.onReceiveFields(pos, formName, fields, sender);
	}

	// override function onRightClick(pos: EngineVector3, node: Dynamic, clicker: Null<ObjectRefBase>, itemStack: ItemStack, pointedThing: Null<PointedThing>): ItemStack {
	// 	trace("I have been clicked");
	// 	return super.onRightClick(pos, node, clicker, itemStack, pointedThing);
	// }

	override function onSecondaryUse(itemstack: ItemStack, user: Null<ObjectRefBase>, pointedThing: PointedThing): Null<ItemStack> {
		return super.onSecondaryUse(itemstack, user, pointedThing);
	}

	override function onTimer(pos: EngineVector3, elapsed: Float, node: Dynamic, timeout: Float): Bool {
		return super.onTimer(pos, elapsed, node, timeout);
	}

	override function onUse(itemstack: ItemStack, user: Null<ObjectRefBase>, pointedThing: PointedThing): Null<ItemStack> {
		return super.onUse(itemstack, user, pointedThing);
	}

	override function preserveMetadata(pos: EngineVector3, oldNode: Dynamic, oldMeta: Dynamic, drops: Array<ItemStack>) {
		super.preserveMetadata(pos, oldNode, oldMeta, drops);
	}

	override function onPlace(itemstack: ItemStack, placer: Null<ObjectRefBase>, pointedThing: PointedThing): Null<ItemStack> {
		trace("cool!");
		return super.onPlace(itemstack, placer, pointedThing);
	}
}
