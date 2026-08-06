package src.game.entity;

import src.engine.ItemStack;
import src.engine.compilercode.Macros;
import src.engine.entity.LuaEntity;
import src.engine.entity.definition.EntityCollisionBox;
import src.engine.vector.Vec2;

@:register(":__builtin:item")
class ItemEntity extends LuaEntity {
	@:native("set_item")
	public function setItem(item: String): Void {
		var stack = ItemStack.create(item);
		untyped print(stack.getName(), stack.getCount());
		// untyped print(newItem.getName());
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
