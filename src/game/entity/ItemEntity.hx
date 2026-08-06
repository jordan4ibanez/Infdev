package src.game.entity;

import haxe.extern.EitherType;
import lua.Math;
import src.engine.Core;
import src.engine.GameInfo;
import src.engine.ItemStack;
import src.engine.compilercode.Macros;
import src.engine.definition.ItemDefinition;
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
	var age = 0;
	// Pushing item out of solid nodes.
	var force_out = null;
	var force_out_start = null;
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

	override function onStep(delta:Float, moveResult:MoveResult) {
		super.onStep(delta, moveResult);

		this.age += dtime;

		if (time_to_live > 0 && this.age > time_to_live) {
			this.itemstring = "";
			this.object.remove();
			return;
		}

		var pos = this.object.get_pos();
		var node = core.get_node_or_nil(new Vec3(
			pos.x,
			pos.y + this._collisionbox[2] - 0.05,
			pos.z
		));
		// Delete in 'ignore' nodes
		if (node != null && node.name == "ignore") {
			this.itemstring = "";
			this.object.remove();
			return;
		}

		// Prevent assert when item_entity is attached
		if (moveresult == null && this.object.get_attach()) {
			return;
		}

		if (this.force_out) {
			// This code runs after the entity got a push from the is_stuck code.
			// It makes sure the entity is entirely outside the solid node
			var c = this._collisionbox;
			var s = this.force_out_start;
			var f = this.force_out;
			
			// todo: 0 index these.
			var ok = (f.x > 0 && pos.x + c[1] > s.x + 0.5) ||
				(f.y > 0 && pos.y + c[2] > s.y + 0.5) ||
				(f.z > 0 && pos.z + c[3] > s.z + 0.5) ||
				(f.x < 0 && pos.x + c[4] < s.x - 0.5) ||
				(f.z < 0 && pos.z + c[6] < s.z - 0.5);
			if (ok) {
				// Item was successfully forced out.
				this.force_out = null;
				this.enable_physics();
				return;
			}
		}

		if (! this.physical_state) {
			// Don't do anything.
			return; 
		}

		assert(moveresult,
			"Collision info missing, this is caused by an out-of-date/buggy mod or game")

		if not moveresult.collides then
			// future TODO: items should probably decelerate in air
			return
		end

		// Push item out when stuck inside solid node
		local is_stuck = false
		local snode = core.get_node_or_nil(pos)
		if snode then
			local sdef = core.registered_nodes[snode.name] or {}
			is_stuck = (sdef.walkable == nil or sdef.walkable == true)
				and (sdef.collision_box == nil or sdef.collision_box.type == "regular")
				and (sdef.node_box == nil or sdef.node_box.type == "regular")
		end

		if is_stuck then
			local shootdir
			local order = {
				{x=1, y=0, z=0}, {x=-1, y=0, z= 0},
				{x=0, y=0, z=1}, {x= 0, y=0, z=-1},
			}

			// Check which one of the 4 sides is free
			for o = 1, #order do
				local cnode = core.get_node(vector.add(pos, order[o])).name
				local cdef = core.registered_nodes[cnode] or {}
				if cnode ~= "ignore" and cdef.walkable == false then
					shootdir = order[o]
					break
				end
			end
			// If none of the 4 sides is free, check upwards
			if not shootdir then
				shootdir = {x=0, y=1, z=0}
				local cnode = core.get_node(vector.add(pos, shootdir)).name
				if cnode == "ignore" then
					shootdir = nil // Do not push into ignore
				end
			end

			if shootdir then
				// Set new item moving speed accordingly
				local newv = vector.multiply(shootdir, 3)
				self:disable_physics()
				this.object:set_velocity(newv)

				this.force_out = newv
				this.force_out_start = vector.round(pos)
				return
			end
		end

		node = nil // ground node we're colliding with
		if moveresult.touching_ground then
			for _, info in ipairs(moveresult.collisions) do
				if info.axis == "y" then
					node = core.get_node(info.node_pos)
					break
				end
			end
		end

		// Slide on slippery nodes
		local def = node and core.registered_nodes[node.name]
		local keep_movement = false

		if def then
			local slippery = core.get_item_group(node.name, "slippery")
			local vel = this.object:get_velocity()
			if slippery ~= 0 and (math.abs(vel.x) > 0.1 or math.abs(vel.z) > 0.1) then
				// Horizontal deceleration
				local factor = math.min(4 / (slippery + 4) * dtime, 1)
				this.object:set_velocity({
					x = vel.x * (1 - factor),
					y = 0,
					z = vel.z * (1 - factor)
				})
				keep_movement = true
			end
		end

		if not keep_movement then
			this.object:set_velocity({x=0, y=0, z=0})
		end

		if this.moving_state == keep_movement then
			// Do not update anything until the moving state changes
			return
		end
		this.moving_state = keep_movement

		// Only collect items if not moving
		if this.moving_state then
			return
		end
		// Collect the items around to merge with
		local own_stack = ItemStack(this.itemstring)
		if own_stack:get_free_space() == 0 then
			return
		end
		local objects = core.get_objects_inside_radius(pos, 1.0)
		for k, obj in pairs(objects) do
			local entity = obj:get_luaentity()
			if entity and entity.name == "__builtin:item" then
				if self:try_merge_with(own_stack, obj, entity) then
					own_stack = ItemStack(this.itemstring)
					if own_stack:get_free_space() == 0 then
						return
					end
				end
			end
		end

	}
}
