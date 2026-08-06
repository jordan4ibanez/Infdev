package src.engine.entity;

import src.engine.definition.basic.MaxLevel.MAX_LEVEL;
import src.engine.definition.basic.ToolCapabilities;
import src.engine.entity.definition.EntityCollisionBox;
import src.engine.entity.objectref.ObjectRefBase;
import src.engine.entity.objectref.ObjectRefEntity;
import src.engine.vector.Vec2;
import src.engine.vector.Vec3;

inline final MAX_ENTITY_LEVEL = MAX_LEVEL;

@:autoBuild(src.engine.compilercode.EntityDuctTape.build())
@:build(src.engine.compilercode.EntityDuctTape.build())
abstract class LuaEntity {
	final object: ObjectRefEntity = null;
	final name: String = null;
	var shadowEnabled = true;
	var shadowEntity: Null<ObjectRefEntity> = null;

	// ? Custom stuff so everything is uniform across the game.
	var size: Vec2 = new Vec2(1, 1);

	@:noCompletion
	static function registerEntity(name: String, clazz: Class<LuaEntity>): Void {
		var rawLuantiPrototype: Dynamic = {}
		// ? Works from the current class backwards until reached root (Entity).
		var currentClass: Class<Dynamic> = clazz;
		while (currentClass != null) {
			// trace("in class: " + Type.getClassName(currentClass));
			// Class components.
			var prototype = Reflect.field(currentClass, "prototype");
			for (method in Reflect.fields(prototype)) {
				untyped {
					if (rawLuantiPrototype[method] != null) {
						// trace("skipping method " + method + " already has it from child class");
						continue;
					}
					rawLuantiPrototype[method] = Reflect.getProperty(prototype, method);
				}
				// trace(method);
			}
			// Move up the inheritance tree.
			currentClass = Type.getSuperClass(currentClass);
		}
		Core.register_entity(name, rawLuantiPrototype);
	}

	/**
	 * Set the size of the entity.
	 * @param width Collision box width total.
	 * @param height Collision box height total.
	 */
	public function setSize(width: Float, height: Float): Void {
		this.size.setFloats(width, height);
		// This sets the collisionbox where it's bottom is it's actual position.
		// Makes things a lot easier.
		this.object.setProperties({
			collisionbox: new EntityCollisionBox(
				-this.size.x * 0.5, 0, -this.size.x * 0.5,
				this.size.x * 0.5, this.size.y, this.size.x * 0.5)
		});
	}

	/**
	 * Get the size of the entity.
	 * @return Vec2 The size of the entity.
	 */
	public function getSize(): Vec2 {
		return this.size;
	}

	/**
	 * Enable having a shadow under this entity.
	 */
	public function enableShadow(?size: Float): Void {
		// Stops shadows from spawning shadows.

		this.shadowEntity = Core.addEntity(this.object.getPos(), "infdev:entity_shadow", this.object.getGUID());
		// The entity may disappear immediately.
		if (this.shadowEntity != null) {
			this.shadowEntity.setAttach(this.object, "", new Vec3(0, 0, 0), new Vec3(0, 0, 0), true);
		} else {
			Core.log(LogLevelError, 'Tried to spawn entity shadow at ${this.object.getPos()} but it became null instantly.');
			return;
		}
		if (size != null) {
			this.setShadowSize(size);
		}
	}

	public function setShadowSize(size: Float): Void {
		if (this.shadowEntity == null) {
			Core.log(LogLevelError, 'Tried to set shadow size when the shadow entity doesn\'t exist. ${this.name}');
			return;
		}
		this.shadowEntity.setProperties({
			visual_size: new Vec3(size, size, size)
		});
	}

	// ? Here begins programmer facing overrideable methods.

	@:native("on_activate")
	public function onActivate(staticData: String, dtimeS: Float) {
		this.setSize(1, 1);
	}

	@:native("on_deactivate")
	public function onDeactivate(removal: Bool) {}

	@:native("on_step")
	public function onStep(delta: Float, moveResult: MoveResult) {}

	@:native("on_punch")
	public function onPunch(puncher: Null<ObjectRefBase>, timeFromLastPunch: Float, toolCapabilities: ToolCapabilities, dir: Vec3, damager: Int) {}

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
