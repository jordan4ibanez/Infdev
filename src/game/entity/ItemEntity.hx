package src.game.entity;

import lua.Math;
import src.engine.Core;
import src.engine.ItemStack;
import src.engine.compilercode.Macros;
import src.engine.definition.ItemDefinition;
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
	var _collisionbox: EntityCollisionBox = null;

	@:native("set_item")
	public function setItem(item: String): Void {
		var stack = ItemStack.create(item ?? this.itemstring);

		this.itemstring = stack.toString();
		if (this.itemstring == "") {
			// item not yet known.
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
