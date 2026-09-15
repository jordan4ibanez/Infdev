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
import src.engine.vector.Vec2;
import src.engine.vector.Vec3;

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
	// Item expiry.
	var age: Float = 0;
	var item: String = "";
	var count: Int = 0;

	static inline var offsetMultiplier = 5.0;

	public var droppedBy: Null<String>;

	static final ENTITY_TIME_LIMIT: Float = 300;

	public function addItem(itemStack: ItemStack): Void {
		this.item = itemStack.getName();
		this.count = itemStack.getCount();
	}

	public function updateItems(): Void {
		// ! This is done in 2 chunks on purpose. This is for clarity.
		//
		// ? Step 1: Build the nametag.
		var nameTagString = "";
		for (itemName => count in this.items) {
			// untyped print(itemName, count);
			var registeredDescription = Core.registeredItems[cast itemName].description;
			var finalOutput = registeredDescription == null ? itemName : registeredDescription;
			nameTagString += '${finalOutput} ${count}\n';
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

				// Set a random offset after initial item.
				var offsetPos = new Vec3();
				if (this.object.getChildren().length > 1) {
					var base = lua.Math.random(-1, 1);
					if (base == 0) {
						base = 1;
					}
					offsetPos.x = lua.Math.random() * base * offsetMultiplier;
					base = lua.Math.random(-1, 1);
					if (base == 0) {
						base = 1;
					}
					offsetPos.y = lua.Math.random() * base * offsetMultiplier;
					base = lua.Math.random(-1, 1);
					if (base == 0) {
						base = 1;
					}
					offsetPos.z = lua.Math.random() * base * offsetMultiplier;
				}

				// Set a random rotation after initial item.
				var offsetRotation = new Vec3();
				if (this.object.getChildren().length > 1) {
					var base = lua.Math.random(-1, 1);
					if (base == 0) {
						base = 1;
					}
					offsetRotation.x = lua.Math.random() * base;
					offsetRotation.y = lua.Math.random() * 360.0;
					base = lua.Math.random(-1, 1);
					if (base == 0) {
						base = 1;
					}
					offsetRotation.z = lua.Math.random() * base;
				}

				visualEntity.setAttach(this.object, "magic_item_floater", offsetPos, offsetRotation, true);

				var viLuaEnt = (cast visualEntity.getLuaEntity() : ItemEntityVisual);
				viLuaEnt.setItem(itemName);
				this.noSaveVisualItems.set(itemName, visualEntity);
			}
		}
	}

	function tryJoinItemEntities(): Bool {
		for (obj in Core.getObjectsInsideRadius(this.object.getPos(), 0.2)) {
			if (!obj.isPlayer()) {
				if (obj.getLuaEntity().name == "__builtin:item") {
					// Skip self.
					if (obj.getGUID() == this.object.getGUID()) {
						continue;
					}

					var otherItem = (cast obj.getLuaEntity() : ItemEntity);

					for (item => count in this.items) {
						// untyped print("adding", item, count);
						otherItem.addItem(ItemStack.create('${item} ${count}'));
					}

					this.object.remove();
					return true;
				}
			}
		}
		return false;
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
			nametag_scale_z: true,
			nametag_fontsize: 24
		});

		this.object.playAnimation("item_spin", {speed: 0.4});

		this.setSize(0.6, 0.6);

		this.object.setArmorGroups(["immortal" => 1]);
		this.object.setVelocity(new Vec3(0, 0, 0));
		this.object.setAcceleration(new Vec3(0, 0, 0));

		this.enableShadow(1.5);

		this.updateItems();

		// Do the initial check to combine item entities when an item gets added to the world.
		// But only after 1 server step.
		Core.after(0, () -> {
			// Maybe it instantly disappeared.
			if (this.object == null) {
				return;
			}
			// This may remove the item entity.
			this.tryJoinItemEntities();
		});
	}

	override function onDeactivate(removal: Bool) {
		super.onDeactivate(removal);
		untyped print("remove from entity on tick");
	}

	override function onStep(delta: Float, moveResult: MoveResult) {
		super.onStep(delta, moveResult);

		this.age += delta;

		if (this.age > ENTITY_TIME_LIMIT) {
			this.items = [];
			this.object.remove();
			return;
		}
	}

	// Returns if it moved.
	function physicsCheck(pos: Vec3): Bool {
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
				return true;
			}
		}

		// Gravity.
		var positionBelow = pos.subtract(new Vec3(0, 1, 0));
		var nodeBelow = Core.getNode(positionBelow).name;
		if (!Core.registeredNodes[cast nodeBelow].walkable) {
			this.object.moveTo(positionBelow.round().subtract(new Vec3(0, 0.49, 0)));
			return true;
		}

		return false;
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
			// Try to join to combine other entities when the entity moves around.
			if (this.physicsCheck(pos)) {
				if (this.tryJoinItemEntities()) {
					// Joining succeeded. It no longer exists.
					return;
				}
			}
		}
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
