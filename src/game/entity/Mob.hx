package src.game.entity;

import luantitypes.Macros;
import luantitypes.Core;
import engine.vector.Vec3;
import engine.entity.helpers.EntitySerialization;
import engine.entity.LuaEntity;

// This is how your class gets registered into the engine.
@:luantiEntity("infdev:mob")
abstract class Mob extends LuaEntity {
	var helperVec3 = new Vec3();

	override function onActivate(staticData: String, dtimeS: Float) {
		super.onActivate(staticData, dtimeS);

		EntitySerialization.safeDeserialize(staticData, this, Macros.getCompileTimeClass());
	}

	override function onStep(delta: Float, moveResult: Dynamic) {
		super.onStep(delta, moveResult);

		this.object.rightClick(this.object);
	}

	override function getStaticData(): String {
		return EntitySerialization.safeSerialize(this, Macros.getCompileTimeClass());
	}
}
