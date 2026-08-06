package src.game.entity;

import src.engine.entity.objectref.ObjectRefBase;
import lua.Math;
import src.engine.Core;
import src.engine.GameInfo;
import src.engine.ItemStack;
import src.engine.compilercode.Macros;
import src.engine.definition.ItemDefinition;
import src.engine.entity.LuaEntity;
import src.engine.entity.definition.EntityCollisionBox;
import src.engine.entity.helpers.EntitySerialization;
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

	static final defaultCollisionBox: EntityCollisionBox = new EntityCollisionBox(-0.3, -0.3, -0.3, 0.3, 0.3, 0.3);

	@:native("set_item")
	public function setItem(?item: String): Void {
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

	function tryMergeWith(ownStack, object: ObjectRefBase, entity: ItemEntity): Bool {
		// todo: update this to use the object UUID.
		if (self.age == entity.age) {
			// Cannot merge with itself
			return false;
		}

		var stack = ItemStack(entity.itemstring);
		var name = stack.getName();
		if own_stack:get_name() ~= name or
				own_stack:get_meta() ~= stack:get_meta() or
				own_stack:get_wear() ~= stack:get_wear() or
				own_stack:get_free_space() == 0 then
			// Cannot merge different or full stack
			return false
		end

		local count = own_stack:get_count()
		local total_count = stack:get_count() + count
		local max_count = stack:get_stack_max()

		if total_count > max_count then
			return false
		end
		// Merge the remote stack into this one

		local pos = object:get_pos()
		pos.y = pos.y + ((total_count - count) / max_count) * 0.15
		self.object:move_to(pos)

		self.age = 0 // Handle as new entity
		own_stack:set_count(total_count)
		self:set_item(own_stack)

		entity.itemstring = ""
		object:remove()
		return true

	}
}
