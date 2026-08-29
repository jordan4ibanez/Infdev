package src.game.entity;

import src.engine.Core;
import src.engine.ItemStack;
import src.engine.Serialize;
import src.engine.Tick;
import src.engine.compilercode.Macros;
import src.engine.definition.basic.ToolCapabilities;
import src.engine.entity.LuaEntity;
import src.engine.entity.MoveResult;
import src.engine.entity.objectref.ObjectRefBase;
import src.engine.entity.objectref.ObjectRefEntity;
import src.engine.vector.Vec2;
import src.engine.vector.Vec3;

// todo: instead of the entity just adding to inventory, check if the wield slot can be added to so you literally pick up the item in your hand.
// This is the entity that gets mounted to the item's bone. It allows the item to have a cool visual.

@:register("infdev:item_entity_visual")
class ItemEntityVisual extends LuaEntity {
	var controllerEntity: Null<ObjectRefBase> = null;

	public function setItem(item: String): Void {
		this.object.setProperties({
			wield_item: item
		});
	}

	// The visual entity shall be created with the item name as it's static data.
	override function onActivate(staticData: String, dtimeS: Float) {
		Macros.entityPatch();
		super.onActivate(staticData, dtimeS);

		// It needs to be created with the controller entity's GUID.
		if (staticData == "") {
			this.object.remove();
			return;
		}

		this.object.setProperties({
			pointable: false,
			static_save: false,
			visual: EntityVisualWieldItem,
			collide_with_objects: false,
			wield_item: "",
			physical: false,
			is_visible: true,
		});

		// Hook up the controller entity into this by reference so the global table doesn't need to hammer RAM.
		// Also if it doesn't exist something exploded.
		this.controllerEntity = Core.getObjectByGUID(staticData);
		if (this.controllerEntity == null) {
			Core.log(LogLevelError, "Item entity visual created with a null controller entity.");
			this.object.remove();
			return;
		}
	}

	override function onStep(delta: Float, moveResult: MoveResult) {
		super.onStep(delta, moveResult);
		if (controllerEntity == null || !controllerEntity.isValid() || this.object.getAttach() == null) {
			this.object.remove();
			return;
		}
	}
}

@:register(":__builtin:item")
class ItemEntity extends LuaEntity {
	var items: Map<String, Int> = new Map();
	var noSaveVisualItems: Map<String, ObjectRefEntity> = new Map();
	var visualEntity: Null<ObjectRefEntity> = null;

	var moving_state = true;
	// Item expiry.
	var age: Float = 0;

	var doPhysicsChecks: Bool = true;

	public var droppedBy: Null<String>;

	static final ENTITY_TIME_LIMIT: Float = 300;

	public function addItem(itemStack: ItemStack): Void {
		var itemName = itemStack.getName();
		var itemCount = itemStack.getCount();

		if (this.items.exists(itemName)) {
			var currentCount = this.items.get(itemName);
			currentCount += itemCount;
			this.items.set(itemName, currentCount);
		} else {
			this.items.set(itemName, itemCount);
		}

		this.updateItems();
	}

	public function updateItems(): Void {
		// ! This is done in 2 chunks on purpose. This is for clarity.
		//
		// ? Step 1: Build the nametag.
		var nameTagString = "";
		for (itemName => count in this.items) {
			untyped print(itemName, count);
			nameTagString += '${itemName} ${count}\n';
		}
		nameTagString = nameTagString.substring(0, nameTagString.length - 1);

		this.object.setNametagAttributes({
			text: nameTagString
		});

		// ?Step 2: Ensure an entity visual is present for each item.

		for (itemName => count in this.items) {
			if (!this.noSaveVisualItems.exists(itemName)) {
				var visualEntity = Core.addEntity(this.object.getPos(), "infdev:item_entity_visual", this.object.getGUID());

				// Bail out.
				if (visualEntity == null) {
					Core.log(LogLevelError, 'Failed to attach visual entity to item at ${this.object.getPos()}');
					return;
				}

				// todo: This should probably randomize if contains more than 1 item.
				visualEntity.setAttach(this.object, "magic_item_floater", new Vec3(0, 0, 0), new Vec3(0, 0, 0), true);

				var viLuaEnt = (cast visualEntity.getLuaEntity() : ItemEntityVisual);
				viLuaEnt.setItem(itemName);
				this.noSaveVisualItems.set(itemName, visualEntity);
			}
		}

		// var stack = ItemStack.create(item ?? this.itemstring);
		// this.visualEntity = Core.addEntity(this.object.getPos(), "infdev:item_entity_visual", this.object.getGUID());
		// // The entity may disappear immediately.
		// if (this.visualEntity != null) {
		// 	this.visualEntity.setAttach(this.object, "magic_item_floater", new Vec3(0, 0, 0), new Vec3(0, 0, 0), true);
		// } else {
		// 	Core.log(LogLevelError, 'Tried to spawn item entity visual at ${this.object.getPos()} but it became null instantly. This item is now invisible.');
		// }

		// this.itemstring = stack.toString();
		// if (this.itemstring == "") {
		// 	// Item not yet known.
		// 	return;
		// }
		// var itemname = stack.getName();
		// var def: Null<ItemDefinition> = Core.registeredItems[cast itemname];
		// var glow = (def != null && def.lightSource != null && def.lightSource > 0) ? Math.floor(def.lightSource / 2 + 0.5) : null;
		// this.setSize(0.6, 0.6);
		// The entity visual inherits this size.
		// this.object.setProperties({
		// 	visual: EntityVisualMesh,
		// 	visual_size: new Vec2(0.3, 0.3),
		// 	infotext: "An item!",
		// 	pointable: true,
		// 	// This is perfectly glitchy!
		// 	nametag_scale_z: true,
		// 	nametag: stack.getDescription(),
		// 	nametag_color: "white",
		// 	nametag_bgcolor: new RGBA(0, 0, 0, 0),
		// 	nametag_fontsize: 30,
		// });

		// Needs to manage multiple entities.
		// this.visualEntity = Core.addEntity(this.object.getPos(), "infdev:item_entity_visual", this.object.getGUID());
		// // The entity may disappear immediately.
		// if (this.visualEntity != null) {
		// 	this.visualEntity.setAttach(this.object, "magic_item_floater", new Vec3(0, 0, 0), new Vec3(0, 0, 0), true);
		// } else {
		// 	Core.log(LogLevelError, 'Tried to spawn item entity visual at ${this.object.getPos()} but it became null instantly. This item is now invisible.');
		// }
	}

	override function getStaticData(): String {
		return Serialize.serializeHaxeObject(this, Macros.getCompileTimeClass());
	}

	override function onActivate(staticData: String, dtimeS: Float) {
		Macros.entityPatch();
		super.onActivate(staticData, dtimeS);

		Tick.registerOnTickEntity(this.object);
		Serialize.deserializeHaxeObject(staticData, this, Macros.getCompileTimeClass());

		this.object.setProperties({
			hp_max: 1,
			physical: true,
			collide_with_objects: false,
			visual: EntityVisualMesh,
			visual_size: new Vec2(0.4, 0.4),
			mesh: "infdev_item_entity.gltf",
			is_visible: true,
			nametag_scale_z: true
		});

		this.object.playAnimation("item_spin", {speed: 0.4});

		this.setSize(0.6, 0.6);

		this.object.setArmorGroups(["immortal" => 1]);
		this.object.setVelocity(new Vec3(0, 0, 0));
		this.object.setAcceleration(new Vec3(0, 0, 0));

		this.enableShadow(1.5);

		this.updateItems();
	}

	override function onDeactivate(removal: Bool) {
		super.onDeactivate(removal);
		untyped print("remove from entity on tick");
	}

	// function tryMergeWith(own_stack: ItemStack, object: ObjectRefBase, entity: ItemEntity): Bool {
	// 	if (this.object.getGUID() == entity.object.getGUID()) {
	// 		// Cannot merge with itself
	// 		return false;
	// 	}
	// 	var stack = ItemStack.create(entity.itemstring);
	// 	var name = stack.getName();
	// 	if (own_stack.getName() != name
	// 		|| own_stack.getMeta() != stack.getMeta()
	// 		|| own_stack.getWear() != stack.getWear()
	// 		|| own_stack.getFreeSpace() == 0) {
	// 		// Cannot merge different or full stack.
	// 		return false;
	// 	}
	// 	var count = own_stack.getCount();
	// 	var total_count = stack.getCount() + count;
	// 	var max_count = stack.getStackMax();
	// 	if (total_count > max_count) {
	// 		return false;
	// 	}
	// 	// Merge the remote stack into this one.
	// 	var pos = object.getPos();
	// 	pos.y = pos.y + ((total_count - count) / max_count) * 0.15;
	// 	this.object.moveTo(pos);
	// 	// Handle as new entity
	// 	own_stack.setCount(total_count);
	// 	this.updateItems(own_stack);
	// 	entity.itemstring = "";
	// 	var otherLuaEntity = (cast object.getLuaEntity() : ItemEntity);
	// 	otherLuaEntity.shadowEntity.remove();
	// 	otherLuaEntity.visualEntity.remove();
	// 	// Keep the greatest age between the two.
	// 	this.age = (this.age > otherLuaEntity.age) ? this.age : otherLuaEntity.age;
	// 	object.remove();
	// 	return true;
	// }
	override function onStep(delta: Float, moveResult: MoveResult) {
		super.onStep(delta, moveResult);

		this.age += delta;

		if (this.age > ENTITY_TIME_LIMIT) {
			this.items = [];
			this.object.remove();
			return;
		}
	}

	function physicsCheck(pos: Vec3): Void {
		// Push item out when stuck inside solid node
		var is_stuck = false;
		var snode = Core.getNodeOrNull(pos);
		if (snode != null) {
			var sdef = Core.registeredNodes[cast snode.name];
			is_stuck = (sdef.walkable == null || sdef.walkable == true)
				&& (sdef.collisionBox == null || sdef.collisionBox.type == NodeBoxTypeRegular)
				&& (sdef.nodeBox == null || sdef.nodeBox.type == NodeBoxTypeRegular);
		}

		if (is_stuck) {
			var shootdir = null;
			var order = [
				new Vec3(1, 0, 0), new Vec3(-1, 0, 0),
				new Vec3(0, 0, 1), new Vec3(0, 0, -1),
			];

			// Check which one of the 4 sides is free.
			for (direction in order) {
				var cnode = Core.getNode(pos.add(direction)).name;
				var cdef = Core.registeredNodes[cast cnode];
				if (cnode != "ignore" && (cdef == null || cdef.walkable == false)) {
					shootdir = direction;
					break;
				}
			}
			// If none of the 4 sides is free, check upwards
			if (shootdir == null) {
				shootdir = new Vec3(0, 1, 0);
				var cnode = Core.getNode(pos.add(shootdir)).name;
				if (cnode == "ignore") {
					// Do not push into ignore.
					shootdir = null;
				}
			}

			if (shootdir != null) {
				this.object.moveTo(this.object.getPos().add(shootdir));
				return;
			}
		}

		// Gravity.
		var positionBelow = pos.subtract(new Vec3(0, 1, 0));
		var nodeBelow = Core.getNode(positionBelow).name;
		if (!Core.registeredNodes[cast nodeBelow].walkable) {
			this.object.moveTo(positionBelow.round().subtract(new Vec3(0, 0.49, 0)));
		}
	}

	override function onTick() {
		super.onTick();

		var pos = this.object.getPos();

		var node = Core.getNodeOrNull(new Vec3(
			pos.x,
			pos.y - 0.05,
			pos.z
		));

		// Delete in 'ignore' nodes
		if (node != null && node.name == "ignore") {
			this.items = [];
			this.object.remove();
			return;
		}

		// Physics logic. Runs at 50 ticks per minute.
		this.doPhysicsChecks = !this.doPhysicsChecks;

		if (this.doPhysicsChecks) {
			this.physicsCheck(pos);
		}

		// Collect the items around to merge with.
		// var own_stack = ItemStack.create(this.itemstring);
		// if (own_stack.getFreeSpace() == 0) {
		// 	return;
		// }

		// var objects: LuaArray<ObjectRefBase> = Core.getObjectsInsideRadius(pos, 1.0);

		// LuaLoop.nativePairs(k, o, objects, {
		// 	var obj = (cast o : ObjectRefBase);
		// 	var entity = obj.getLuaEntity();
		// 	if (entity != null && entity.name == "__builtin:item") {
		// 		if (this.tryMergeWith(own_stack, obj, cast entity)) {
		// 			own_stack = ItemStack.create(this.itemstring);
		// 			if (own_stack.getFreeSpace() == 0) {
		// 				return;
		// 			}
		// 		}
		// 	}
		// });
	}

	override function onPunch(puncher: Null<ObjectRefBase>, timeFromLastPunch: Float, toolCapabilities: ToolCapabilities, dir: Vec3, damager: Int) {
		super.onPunch(puncher, timeFromLastPunch, toolCapabilities, dir, damager);

		// if (this.itemstring == "") {
		// 	this.object.remove();
		// 	return;
		// }

		// // Call on_pickup callback in item definition.
		// var itemstack = ItemStack.create(this.itemstring);
		// var callback = untyped itemstack.getDefinition().on_pickup;

		// var ret = callback(itemstack, puncher, {type: PointedThingTypeObject, ref: this.object}, timeFromLastPunch);

		// if (ret == null) {
		// 	// Don't modify (and don't reset rotation).
		// 	return;
		// }
		// itemstack = ItemStack.create(ret);

		// // Handle the leftover itemstack
		// if (itemstack.isEmpty()) {
		// 	this.itemstring = "";
		// 	this.object.remove();
		// } else {
		// 	this.updateItems(itemstack);
		// }
	}
}
