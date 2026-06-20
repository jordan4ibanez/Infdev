package game;

import lua.Lua;
import luantitypes.Core;
import haxe.extern.EitherType;
import engine.definition.PointedThing;
import engine.entity.objectref.ObjectRefBase;
import engine.ItemStack;
import engine.definition.TouchInteractionSetting;
import engine.definition.sound.ItemSoundTable;
import engine.definition.images.WearBarColors;
import engine.definition.ToolCapabilities;
import engine.definition.Pointabilities;
import engine.vector.EngineVector3;
import engine.definition.images.ItemImageDefinition.ItemImageDefinitionOrString;
import engine.definition.ItemDefinition;
import engine.definition.NodeDefinition;

// Static wrapper.
// This one is modeled off of ItemDefinition.
// final class DirtWrapper {
// 	private function new() {}
// 	// Holds it in memory for extra stupid stuff.
// 	static var instance: Dirt;
// 	static function __init__() {
// 		instance = new Dirt();
// 		// trace("instance:", instance);
// 		// trace("wrapper:", DirtWrapper);
// 		// So this copies in the virtual constant fields.
// 		for (field in Reflect.fields(instance)) {
// 			trace("field", field);
// 			untyped DirtWrapper[field] = Reflect.field(instance, field);
// 		}
// 		Core.registerNode("infdev:dirt", DirtWrapper);
// 		for (field in Type.getInstanceFields(Dirt)) {
// 			trace("instance", field);
// 		}
// 		// for (field in Reflect.fields(Dirt)) {
// 		// 	trace(field);
// 		// }
// 	}
// 	// todo: the macro needs to only define these things if it is defined!
// 	// ! This is an invisible wrapper so there is no need to make it look nice with camel case.
// 	public static function on_secondary_use(itemstack: ItemStack, user: Null<ObjectRefBase>, pointedThing: PointedThing): Void {
// 		instance.onSecondaryUse(itemstack, user, pointedThing);
// 	};
// 	public static function on_drop(itemstack: ItemStack, dropper: Null<ObjectRefBase>, pos: EngineVector3): Null<ItemStack> {
// 		return instance.onDrop(itemstack, dropper, pos);
// 	};
// 	public static function on_pickup(itemstack: ItemStack, picker: Null<ObjectRefBase>, pointedThing: PointedThing, timeFromLastPunch: Float): Null<ItemStack> {
// 		return instance.onPickup(itemstack, picker, pointedThing, timeFromLastPunch);
// 	};
// 	public static function on_use(itemstack: ItemStack, user: Null<ObjectRefBase>, pointedThing: PointedThing): Null<ItemStack> {
// 		return instance.onUse(itemstack, user, pointedThing);
// 	};
// 	// todo: node thing
// 	// todo: digparams
// 	public static function after_use(itemstack: ItemStack, user: Null<ObjectRefBase>, node: Dynamic, digparams: Dynamic): Null<ItemStack> {
// 		return instance.afterUse(itemstack, user, node, digparams);
// 	};
// }
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
		super.afterDestruct(pos, oldNode);
	}

	override function onFlood(pos: EngineVector3, oldNode: Dynamic, newNode: Dynamic): Bool {
		return super.onFlood(pos, oldNode, newNode);
	}

	override function afterDigNode(pos: EngineVector3, oldNode: Dynamic, oldMetaData: Dynamic, digger: Null<ObjectRefBase>) {
		super.afterDigNode(pos, oldNode, oldMetaData, digger);
	}

	override function afterPlaceNode(pos: EngineVector3, placer: Null<ObjectRefBase>, itemstack: ItemStack, pointedThing: PointedThing): Bool {
		return super.afterPlaceNode(pos, placer, itemstack, pointedThing);
	}

	override function afterUse(itemstack: ItemStack, user: Null<ObjectRefBase>, node: Dynamic, digparams: Dynamic): Null<ItemStack> {
		return super.afterUse(itemstack, user, node, digparams);
	}

	override function allowMetadataInventoryMove(pos: EngineVector3, fromList: String, fromIndex: Int, toList: String, toIndex: Int, count: Int, player: Null<ObjectRefBase>): Int {
		return super.allowMetadataInventoryMove(pos, fromList, fromIndex, toList, toIndex, count, player);
	}

	override function allowMetadataInventoryPut(pos: EngineVector3, listname: String, index: Int, stack: ItemStack, player: Null<ObjectRefBase>): Int {
		return super.allowMetadataInventoryPut(pos, listname, index, stack, player);
	}

	override function allowMetadataInventoryTake(pos: EngineVector3, listname: String, index: Int, stack: ItemStack, player: Null<ObjectRefBase>): Int {
		return super.allowMetadataInventoryTake(pos, listname, index, stack, player);
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

	override function onMetadataInventoryPut(pos: EngineVector3, listname: String, index: Int, stack: ItemStack, player: Null<ObjectRefBase>) {
		super.onMetadataInventoryPut(pos, listname, index, stack, player);
	}

	override function onMetadataInventoryTake(pos: EngineVector3, listname: String, index: Int, stack: ItemStack, player: Null<ObjectRefBase>) {
		super.onMetadataInventoryTake(pos, listname, index, stack, player);
	}

	override function onPickup(itemstack: ItemStack, picker: Null<ObjectRefBase>, pointedThing: PointedThing, timeFromLastPunch: Float): Null<ItemStack> {
		return super.onPickup(itemstack, picker, pointedThing, timeFromLastPunch);
	}

	override function onPunch(pos: EngineVector3, node: Dynamic, puncher: Null<ObjectRefBase>, pointedThing: PointedThing) {
		super.onPunch(pos, node, puncher, pointedThing);
	}

	override function onReceiveFields(pos: EngineVector3, formname: String, fields: Dynamic, sender: Dynamic) {
		super.onReceiveFields(pos, formname, fields, sender);
	}

	override function onRightClick(pos: EngineVector3, node: Dynamic, clicker: Null<ObjectRefBase>, itemStack: ItemStack, pointedThing: Null<PointedThing>): ItemStack {
		return super.onRightClick(pos, node, clicker, itemStack, pointedThing);
	}

	override function onSecondaryUse(itemstack: ItemStack, user: Null<ObjectRefBase>, pointedThing: PointedThing): Null<ItemStack> {
		return super.onSecondaryUse(itemstack, user, pointedThing);
	}

	override function onTimer(pos: EngineVector3, elapsed: Float, node: Dynamic, timeout: Float): Bool {
		return super.onTimer(pos, elapsed, node, timeout);
	}

	override function onUse(itemstack: ItemStack, user: Null<ObjectRefBase>, pointedThing: PointedThing): Null<ItemStack> {
		return super.onUse(itemstack, user, pointedThing);
	}

	override function preserverMetadata(pos: EngineVector3, oldNode: Dynamic, oldMeta: Dynamic, drops: Array<ItemStack>) {
		super.preserverMetadata(pos, oldNode, oldMeta, drops);
	}

	override function onPlace(itemstack: ItemStack, placer: Null<ObjectRefBase>, pointedThing: PointedThing): Null<ItemStack> {
		trace("cool!");
		return super.onPlace(itemstack, placer, pointedThing);
	}
}
