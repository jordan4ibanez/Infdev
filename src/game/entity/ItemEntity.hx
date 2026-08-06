package src.game.entity;

import src.engine.ItemStack;
import src.engine.compilercode.Macros;
import src.engine.entity.LuaEntity;
import src.engine.entity.definition.EntityCollisionBox;
import src.engine.vector.Vec2;

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

	@:native("set_item")
	public function setItem(item: String): Void {
		var stack = ItemStack.create(item ?? this.itemstring);

		this.itemstring = stack.to_string();
		if (self.itemstring == "") {
			// item not yet known.
			return;
		}

		// todo: break this.
		// Backwards compatibility: old clients use the texture
		// to get the type of the item
		var itemname = stack.is_known() ? stack.get_name() : "unknown";

		local max_count = stack:get_stack_max()
		local count = math.min(stack:get_count(), max_count)
		local size = 0.2 + 0.1 * (count / max_count) ^ (1 / 3)
		local def = core.registered_items[itemname]
		local glow = def and def.light_source and
			math.floor(def.light_source / 2 + 0.5)

		local size_bias = 1e-3 * math.random() // small random bias to counter Z-fighting
		local c = {-size, -size, -size, size, size, size}
		self.object:set_properties({
			is_visible = true,
			visual = "wielditem",
			textures = {itemname},
			visual_size = {x = size + size_bias, y = size + size_bias},
			collisionbox = c,
			automatic_rotate = math.pi * 0.5 * 0.2 / size,
			wield_item = self.itemstring,
			glow = glow,
			infotext = stack:get_description(),
		})

		// cache for usage in on_step
		self._collisionbox = c
	}

	override function onActivate(staticData: String, dtimeS: Float) {
		Macros.entityPatch();
		super.onActivate(staticData, dtimeS);

		this.object.setProperties({
			hp_max: 1,
			physical: true,
			collide_with_objects: false,
			collisionbox: new EntityCollisionBox(-0.3, -0.3, -0.3, 0.3, 0.3, 0.3),
			visual: EntityVisualWieldItem,
			visual_size: new Vec2(0.4, 0.4),
			textures: [""],
			is_visible: false,
		});
	}
}
