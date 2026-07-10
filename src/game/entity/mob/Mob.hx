package src.game.entity.mob;

import src.engine.Core;
import src.engine.compilercode.Macros;
import src.engine.entity.LuaEntity;
import src.engine.entity.helpers.EntitySerialization;
import src.engine.vector.Vec3;

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
