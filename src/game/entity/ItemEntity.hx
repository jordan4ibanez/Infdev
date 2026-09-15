package src.game.entity;

import src.engine.Core;
import src.engine.ItemStack;
import src.engine.Serialize;
import src.engine.compilercode.Macros;
import src.engine.entity.LuaEntity;
import src.engine.entity.MoveResult;
import src.engine.entity.objectref.ObjectRefBase;
import src.engine.entity.objectref.ObjectRefEntity;
import src.engine.vector.Vec2;
import src.engine.vector.Vec3;

@:register("infdev:item_entity_visual")
class ItemEntityVisual extends LuaEntity {
	var controllerEntity: Null<ObjectRefBase> = null;

	public function setItem(item: String): Void {
		this.object.setProperties({
			wield_item: item
		});
	}

	// The visual entity shall be created with the item name as it's static data.
	override function onActivate(staticData: String, dtimeS: Float) {
		Macros.entityPatch();
		super.onActivate(staticData, dtimeS);

		// It needs to be created with the controller entity's GUID.
		if (staticData == "") {
			this.object.remove();
			return;
		}

		this.object.setProperties({
			pointable: false,
			static_save: false,
			visual: EntityVisualWieldItem,
			collide_with_objects: false,
			wield_item: "",
			physical: false,
			is_visible: true,
		});

		// Hook up the controller entity into this by reference so the global table doesn't need to hammer RAM.
		// Also if it doesn't exist something exploded.
		this.controllerEntity = Core.getObjectByGUID(staticData);
		if (this.controllerEntity == null) {
			Core.log(LogLevelError, "Item entity visual created with a null controller entity.");
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
	}
}

@:register(":__builtin:item")
class ItemEntity extends LuaEntity {
	// Item expiry.
	var age: Float = 0;
	var item: String = "";
	var count: Int = 0;
	var visualEntity: Null<ObjectRefEntity> = null;

	static inline var offsetMultiplier = 5.0;

	public var droppedBy: Null<String>;

	static final ENTITY_TIME_LIMIT: Float = 300;

	public function setItem(itemStack: ItemStack): Void {
		this.item = itemStack.getName();
		this.count = itemStack.getCount();
		this.updateVisual();
	}

	function updateVisual(): Void {
		if (this.visualEntity == null) {
			this.visualEntity = Core.addEntity(this.object.getPos(), "infdev:item_entity_visual", this.object.getGUID());

			// Bail out.
			if (this.visualEntity == null) {
				Core.log(LogLevelError, 'Failed to attach visual entity to item at ${this.object.getPos()}');
				return;
			}
			this.visualEntity.setAttach(this.object, "magic_item_floater", new Vec3(), new Vec3(), true);
		}

		(cast this.visualEntity.getLuaEntity() : ItemEntityVisual).setItem(this.item);
	}

	override function getStaticData(): String {
		return Serialize.serializeHaxeObject(this, Macros.getCompileTimeClass());
	}

	override function onActivate(staticData: String, dtimeS: Float) {
		Macros.entityPatch();
		super.onActivate(staticData, dtimeS);

		Serialize.deserializeHaxeObject(staticData, this, Macros.getCompileTimeClass());

		this.object.setProperties({
			hp_max: 1,
			physical: true,
			pointable: false,
			collide_with_objects: false,
			visual: EntityVisualMesh,
			visual_size: new Vec2(0.25, 0.25),
			mesh: "infdev_item_entity.gltf",
			is_visible: true,
			nametag_scale_z: true,
			nametag_fontsize: 24
		});

		this.object.playAnimation("item_spin", {speed: 0.4});

		this.setSize(0.6, 0.6);

		this.object.setArmorGroups(["immortal" => 1]);
		this.object.setVelocity(new Vec3(0, 0, 0));
		this.object.setAcceleration(new Vec3(0, -10.0, 0));

		if (this.item != "") {
			this.updateVisual();
		}

		this.enableShadow(1.5);
	}

	override function onDeactivate(removal: Bool) {
		super.onDeactivate(removal);
		untyped print("remove from entity on tick");
	}

	override function onStep(delta: Float, moveResult: MoveResult) {
		super.onStep(delta, moveResult);

		this.age += delta;

		if (this.age > ENTITY_TIME_LIMIT) {
			this.item = "";
			this.count = 0;
			this.object.remove();
			return;
		}
	}
}
