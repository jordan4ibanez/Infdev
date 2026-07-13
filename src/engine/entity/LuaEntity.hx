package src.engine.entity;

import src.engine.definition.MaxLevel.MAX_LEVEL;
import src.engine.entity.definition.EntityCollisionBox;
import src.engine.entity.objectref.ObjectRefBase;
import src.engine.entity.objectref.ObjectRefEntity;
import src.engine.vector.Vec2;

inline final MAX_ENTITY_LEVEL = MAX_LEVEL;

@:autoBuild(src.engine.compilercode.EntityDuctTape.build())
@:build(src.engine.compilercode.EntityDuctTape.build())
abstract class LuaEntity {
	final object: ObjectRefEntity = null;
	final name: String = null;

	// ? Custom stuff so everything is uniform across the game.
	var size: Vec2 = new Vec2(1, 1);

	/**
	 * Set the size of the entity.
	 * @param width Collision box width total.
	 * @param height Collision box height total.
	 */
	public function setSize(width: Float, height: Float): Void {
		this.size.setFloats(width, height);
		// This sets the collisionbox where it's bottom is it's actual position.
		// Makes things a lot easier.
		this.object.setProperties(new ObjectProperties()
			.setCollisionBox(new EntityCollisionBox(
				-this.size.x * 0.5, 0, -this.size.x * 0.5,
				this.size.x * 0.5, this.size.y, this.size.x * 0.5)));
	}

	/**
	 * Get the size of the entity.
	 * @return Vec2 The size of the entity.
	 */
	public function getSize(): Vec2 {
		return this.size;
	}

	// ? Here begins programmer facing overrideable methods.

	@:native("on_activate")
	public function onActivate(staticData: String, dtimeS: Float) {
		this.setSize(1, 1);
	}

	@:native("on_deactivate")
	public function onDeactivate(removal: Bool) {}

	// todo: fix this dynamic mess.
	// todo: fix return types.

	@:native("on_step")
	public function onStep(delta: Float, moveResult: Dynamic) {}

	@:native("on_punch")
	public function onPunch(puncher: Null<ObjectRefBase>, timeFromLastPunch: Float, toolCapabilities: Dynamic, dir: Dynamic, damager: Int) {}

	@:native("on_death")
	public function onDeath(killer: Null<ObjectRefBase>) {}

	@:native("on_rightclick")
	public function onRightClick(clicker: ObjectRefBase) {}

	@:native("on_attach_child")
	public function onAttachChild(child: ObjectRefBase) {}

	@:native("on_detach_child")
	public function onDetachChild(child: ObjectRefBase) {}

	@:native("on_detach")
	public function onDetach(parent: ObjectRefBase) {}

	@:native("get_staticdata")
	public function getStaticData(): String {
		return "";
	}

	// ? Begin baked in engine entity features made nicer to use.
	// ! If anything past this point isn't final, there's an issue.
	//
	// LuaEntity methods:
	//
	//* begins: remove
	//* ends: get_entity_name (which is deprecated, this thing should use a .name field)
}
