package src.engine.entity;

import src.engine.compilercode.Macros;
import src.engine.definition.basic.MaxLevel.MAX_LEVEL;
import src.engine.definition.basic.ToolCapabilities;
import src.engine.entity.definition.EntityCollisionBox;
import src.engine.entity.objectref.ObjectRefBase;
import src.engine.entity.objectref.ObjectRefEntity;
import src.engine.vector.Vec2;
import src.engine.vector.Vec3;

inline final MAX_ENTITY_LEVEL = MAX_LEVEL;

@:register("infdev:entity_shadow")
class EntityShadow extends LuaEntity {
	var controllerEntity: Null<ObjectRefBase> = null;

	var pollTimer: Float = 0;

	// Don't destroy the server tick rate and only poll every half second.
	static inline final pollRate = 0.5;

	override function onActivate(staticData: String, dtimeS: Float) {
		Macros.entityPatch();
		super.onActivate(staticData, dtimeS);

		// It needs to be created with the controller entity's GUID.
		if (staticData == "") {
			this.object.remove();
			return;
		}

		this.object.setProperties({
			physical: false,
			collide_with_objects: false,
			visual: EntityVisualMesh,
			mesh: "infdev_entity_shadow.gltf",
			textures: ["infdev_entity_shadow.png^[opacity:127"],
			is_visible: true,
			pointable: false,
			use_texture_alpha: true
		});

		// Hook up the controller entity into this by reference so the global table doesn't need to hammer RAM.
		// Also if it doesn't exist something exploded.
		this.controllerEntity = Core.getObjectByGUID(staticData);
		if (this.controllerEntity == null) {
			Core.log(LogLevelError, "Item shadow created with a null controller entity.");
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

		this.pollTimer + delta;

		if (pollTimer < pollRate) {
			return;
		}
		this.pollTimer -= pollRate;

		var pos = this.object.getPos();
		pos.y -= 0.05;

		var walkableBelow = Core.registeredNodes[cast Core.getNode(pos).name].walkable;
		if (walkableBelow == null || walkableBelow == true) {
			this.object.setProperties({is_visible: true});
		} else {
			this.object.setProperties({is_visible: false});
		}
	}
}

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

	// ? Here begins programmer facing overrideable methods.

	@:native("on_activate")
	public function onActivate(staticData: String, dtimeS: Float) {
		this.setSize(1, 1);

		// Stops shadows from spawning shadows.
		if (this.name != "infdev:entity_shadow") {
			this.shadowEntity = Core.addEntity(this.object.getPos(), "infdev:entity_shadow", this.object.getGUID());
			// The entity may disappear immediately.
			if (this.shadowEntity != null) {
				this.shadowEntity.setAttach(this.object, "", new Vec3(0, 0, 0), new Vec3(0, 0, 0), true);
			} else {
				Core.log(LogLevelError, 'Tried to spawn entity shadow at ${this.object.getPos()} but it became null instantly.');
			}
		}
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
