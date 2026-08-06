package src.game.entity;

import haxe.extern.EitherType;
import lua.Lua;
import lua.Math;
import src.engine.Core;
import src.engine.GameInfo;
import src.engine.ItemStack;
import src.engine.compilercode.LuaArray;
import src.engine.compilercode.LuaLoop;
import src.engine.compilercode.Macros;
import src.engine.definition.ItemDefinition;
import src.engine.definition.basic.PointedThing.PointedThingType;
import src.engine.definition.basic.ToolCapabilities;
import src.engine.entity.LuaEntity;
import src.engine.entity.MoveResult;
import src.engine.entity.definition.EntityCollisionBox;
import src.engine.entity.helpers.EntitySerialization;
import src.engine.entity.objectref.ObjectRefBase;
import src.engine.vector.Vec2;
import src.engine.vector.Vec3;

@:register(":__builtin:item")
class ItemEntity extends LuaEntity {
	var itemstring = "";
	var moving_state = true;
	var physical_state = true;
	// Item expiry.
	var age: Float = 0;
	// Pushing item out of solid nodes.
	var force_out: Null<Vec3> = null;
	var force_out_start: Null<Vec3> = null;
	var _collisionbox: EntityCollisionBox = null;

	static final time_to_live: Float = 900;

	static final defaultCollisionBox: EntityCollisionBox = new EntityCollisionBox(-0.3, -0.3, -0.3, 0.3, 0.3, 0.3);

	@:native("set_item")
	public function setItem(?item: EitherType<String, ItemStack>): Void {
		var stack = ItemStack.create(item ?? this.itemstring);

		this.itemstring = stack.toString();
		if (this.itemstring == "") {
			// Item not yet known.
			return;
		}

		// todo: break this.
		// Backwards compatibility: old clients use the texture
		// to get the type of the item
		var itemname = stack.isKnown() ? stack.getName() : "unknown";

		var max_count = stack.getStackMax();
		var count = Math.min(stack.getCount(), max_count);
		var size: Float = 0.2 + 0.1 * Math.pow((count / max_count), (1.0 / 3.0));
		// todo: use get_definition
		var def: Null<ItemDefinition> = Core.registeredItems[cast itemname];

		// todo: probably only define this if it's a light source.
		var glow = (def != null && def.lightSource != null && def.lightSource > 0) ? Math.floor(def.lightSource / 2 + 0.5) : null;

		// Small random bias to counter Z-fighting.
		var size_bias = 1e-3 * Math.random();
		var c = new EntityCollisionBox(-size, -size, -size, size, size, size);

		this.object.setProperties({
			is_visible: true,
			visual: EntityVisualWieldItem,
			textures: [itemname],
			visual_size: new Vec2(size + size_bias, size + size_bias),
			collisionbox: c,
			automatic_rotate: Math.pi * 0.5 * 0.2 / size,
			wield_item: this.itemstring,
			glow: glow,
			infotext: stack.getDescription(),
		});

		// Cache for usage in on_step.
		this._collisionbox = c;
	}

	override function getStaticData(): String {
		return EntitySerialization.safeSerialize(this, Macros.getCompileTimeClass());
	}

	override function onActivate(staticData: String, dtimeS: Float) {
		Macros.entityPatch();
		super.onActivate(staticData, dtimeS);

		this.object.setProperties({
			hp_max: 1,
			physical: true,
			collide_with_objects: false,
			collisionbox: defaultCollisionBox,
			visual: EntityVisualWieldItem,
			visual_size: new Vec2(0.4, 0.4),
			textures: [""],
			is_visible: false,
		});

		EntitySerialization.safeDeserialize(staticData, this, Macros.getCompileTimeClass());

		this.object.setArmorGroups(["immortal" => 1]);
		this.object.setVelocity(new Vec3(0, 2, 0));
		this.object.setAcceleration(new Vec3(0, -GameInfo.gravity, 0));
		this._collisionbox = defaultCollisionBox;
		this.setItem();
	}

	function tryMergeWith(own_stack: ItemStack, object: ObjectRefBase, entity: ItemEntity): Bool {
		// todo: update this to use the object UUID.
		if (this.age == entity.age) {
			// Cannot merge with itself
			return false;
		}

		var stack = ItemStack.create(entity.itemstring);
		var name = stack.getName();
		if (own_stack.getName() != name
			|| own_stack.getMeta() != stack.getMeta()
			|| own_stack.getWear() != stack.getWear()
			|| own_stack.getFreeSpace() == 0) {
			// Cannot merge different or full stack.
			return false;
		}

		var count = own_stack.getCount();
		var total_count = stack.getCount() + count;
		var max_count = stack.getStackMax();

		if (total_count > max_count) {
			return false;
		}

		// Merge the remote stack into this one.

		var pos = object.getPos();
		pos.y = pos.y + ((total_count - count) / max_count) * 0.15;
		this.object.moveTo(pos);

		// Handle as new entity
		this.age = 0;
		own_stack.setCount(total_count);
		this.setItem(own_stack);

		entity.itemstring = "";
		object.remove();
		return true;
	}

	function enablePhysics(): Void {
		if (this.physical_state) {
			return;
		}
		this.physical_state = true;
		this.object.setProperties({physical: true});
		this.object.setVelocity(new Vec3(0, 0, 0));
		this.object.setAcceleration(new Vec3(0, -GameInfo.gravity, 0));
	}

	function disablePhysics(): Void {
		if (!this.physical_state) {
			return;
		}
		this.physical_state = false;
		this.object.setProperties({physical: false});
		this.object.setVelocity(new Vec3(0, 0, 0));
		this.object.setAcceleration(new Vec3(0, 0, 0));
	}

	override function onStep(delta: Float, moveResult: MoveResult) {
		super.onStep(delta, moveResult);

		this.age += delta;

		if (time_to_live > 0 && this.age > time_to_live) {
			this.itemstring = "";
			this.object.remove();
			return;
		}

		var pos = this.object.getPos();
		var node = Core.getNodeOrNull(new Vec3(
			pos.x,
			pos.y + this._collisionbox[1] - 0.05,
			pos.z
		));
		// Delete in 'ignore' nodes
		if (node != null && node.name == "ignore") {
			this.itemstring = "";
			this.object.remove();
			return;
		}

		// Prevent assert when item_entity is attached
		if (moveResult == null && this.object.getAttach()) {
			return;
		}

		if (this.force_out != null) {
			// This code runs after the entity got a push from the is_stuck code.
			// It makes sure the entity is entirely outside the solid node
			var c = this._collisionbox;
			var s = this.force_out_start;
			var f = this.force_out;

			// todo: 0 index these.
			var ok = (f.x > 0 && pos.x + c[1] > s.x + 0.5)
				|| (f.y > 0 && pos.y + c[2] > s.y + 0.5)
				|| (f.z > 0 && pos.z + c[3] > s.z + 0.5)
				|| (f.x < 0 && pos.x + c[4] < s.x - 0.5)
				|| (f.z < 0 && pos.z + c[6] < s.z - 0.5);
			if (ok) {
				// Item was successfully forced out.
				this.force_out = null;
				this.enablePhysics();
				return;
			}
		}

		if (!this.physical_state) {
			// Don't do anything.
			return;
		}

		Lua.assert(moveResult,
			"Collision info missing, this is caused by an out-of-date/buggy mod or game");

		if (!moveResult.collides) {
			// future TODO: items should probably decelerate in air.
			return;
		}

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
				// Set new item moving speed accordingly.
				var newv = shootdir.multiplyScalar(3);
				this.disablePhysics();
				this.object.setVelocity(newv);

				this.force_out = newv;
				this.force_out_start = pos.round();
				return;
			}
		}

		// Ground node we're colliding with.
		node = null;
		if (moveResult.touching_ground) {
			LuaLoop.nativeIpairs(_, info, moveResult.collisions, {
				if (info.axis == "y") {
					node = Core.getNode(info.node_pos);
					LuaLoop.breakLoop();
				}
			});
		}

		// Slide on slippery nodes.
		var def = node == null ? Core.registeredNodes[cast node.name] : null;
		var keep_movement = false;

		if (def != null) {
			var slippery = Core.getItemGroup(node.name, "slippery");
			var vel = this.object.getVelocity();
			if (slippery != 0 && (Math.abs(vel.x) > 0.1 || Math.abs(vel.z) > 0.1)) {
				// Horizontal deceleration.
				var factor = Math.min(4 / (slippery + 4) * delta, 1);
				this.object.setVelocity(new Vec3(
					vel.x * (1 - factor),
					0,
					vel.z * (1 - factor)
				));
				keep_movement = true;
			}
		}

		if (!keep_movement) {
			this.object.setVelocity(new Vec3(0, 0, 0));
		}

		if (this.moving_state == keep_movement) {
			// Do not update anything until the moving state changes.
			return;
		}
		this.moving_state = keep_movement;

		// Only collect items if not moving.
		if (this.moving_state) {
			return;
		}
		// Collect the items around to merge with.
		var own_stack = ItemStack.create(this.itemstring);
		if (own_stack.getFreeSpace() == 0) {
			return;
		}

		var objects: LuaArray<ObjectRefBase> = Core.getObjectsInsideRadius(pos, 1.0);

		LuaLoop.nativePairs(k, o, objects, {
			var obj = (cast o : ObjectRefBase);
			var entity = obj.getLuaEntity();
			if (entity != null && entity.name == "__builtin:item") {
				if (this.tryMergeWith(own_stack, obj, cast entity)) {
					own_stack = ItemStack.create(this.itemstring);
					if (own_stack.getFreeSpace() == 0) {
						return;
					}
				}
			}
		});
	}

	override function onPunch(puncher: Null<ObjectRefBase>, timeFromLastPunch: Float, toolCapabilities: ToolCapabilities, dir: Vec3, damager: Int) {
		super.onPunch(puncher, timeFromLastPunch, toolCapabilities, dir, damager);

		if (this.itemstring == "") {
			this.object.remove();
			return;
		}

		// Call on_pickup callback in item definition.
		var itemstack = ItemStack.create(this.itemstring);
		var callback = untyped itemstack.getDefinition().on_pickup;

		// todo: this ended with: , ...
		var ret = callback(itemstack, puncher, {type: PointedThingTypeObject, ref: this.object}, timeFromLastPunch);

		if (ret == null) {
			// Don't modify (and don't reset rotation).
			return;
		}
		itemstack = ItemStack.create(ret);

		// Handle the leftover itemstack
		if (itemstack.isEmpty()) {
			this.itemstring = "";
			this.object.remove();
		} else {
			this.setItem(itemstack);
		}
	}
}
