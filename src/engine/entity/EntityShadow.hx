package src.engine.entity;

import src.engine.compilercode.Macros;
import src.engine.entity.objectref.ObjectRefBase;

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
