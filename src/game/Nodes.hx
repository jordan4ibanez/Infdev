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

		this.color = "blue";
	}

	override function onPlace(itemstack: ItemStack, placer: Null<ObjectRefBase>, pointedThing: PointedThing): Null<ItemStack> {
		trace("cool!");
		return super.onPlace(itemstack, placer, pointedThing);
	}
}
// @:luantiNode("infdev:dirt")
// class Dirt {
// 	public var description: String;
// 	public var shortDescription: String;
// 	public var groups: Dynamic<Int>;
// 	public var wieldImage: ItemImageDefinitionOrString;
// 	public var wieldOverLay: ItemImageDefinitionOrString;
// 	public var wieldScale: EngineVector3;
// 	public var palette: String;
// 	public var color: String;
// 	public var stackMax: Int;
// 	public var range: Float;
// 	public var liquidsPointable: Bool;
// 	public var pointabilities: Pointabilities;
// 	public var lightSource: Int;
// 	public var toolCapabilities: ToolCapabilities;
// 	public var wearColor: WearBarColors;
// 	public var nodePlacementPrediction: String;
// 	public var nodeDigPrediction: String;
// 	public var touchInteraction: TouchInteractionSetting;
// 	public var sound: ItemSoundTable;
// 	public var afterUse: (itemstack: ItemStack, user: Null<ObjectRefBase>, node: Dynamic, digparams: Dynamic) -> Null<ItemStack>;
// 	public var onUse: (itemstack: ItemStack, user: Null<ObjectRefBase>, pointedThing: PointedThing) -> Null<ItemStack>;
// 	public var onPickup: (itemstack: ItemStack, picker: Null<ObjectRefBase>, pointedThing: PointedThing, timeFromLastPunch: Float) -> Null<ItemStack>;
// 	public var onDrop: (itemstack: ItemStack, dropper: Null<ObjectRefBase>, pos: EngineVector3) -> Null<ItemStack>;
// 	public var onSecondaryUse: (itemstack: ItemStack, user: Null<ObjectRefBase>, pointedThing: PointedThing) -> Void;
// 	public var onPlace: (itemstack: ItemStack, placer: Null<ObjectRefBase>, pointedThing: PointedThing) -> Null<ItemStack>;
// }
