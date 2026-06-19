package game;

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

// Static wrapper.
final class DirtWrapper {
	private function new() {}

	// Holds it in memory for extra stupid stuff.
	static var instance: Dirt;

	static function __init__() {
		instance = new Dirt();

		// trace("instance:", instance);
		// trace("wrapper:", DirtWrapper);

		for (field in Reflect.fields(instance)) {
			trace("field", field);
			untyped DirtWrapper[field] = Reflect.field(instance, field);
		}

		trace("wrapper:", DirtWrapper);
	}
}

// @:luantiNode("infdev:dirt")
class Dirt extends ItemDefinition {
	public function new() {
		super();

		this.color = "red";
	}

	override function onDrop(itemstack: ItemStack, dropper: Null<ObjectRefBase>, pos: EngineVector3): Null<ItemStack> {
		return super.onDrop(itemstack, dropper, pos);
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
