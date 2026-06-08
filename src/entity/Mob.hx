package entity;

import vector.Vec3;
import luanti_types.Core.Global;
import lua.Lua;

abstract class Mob extends LuaEntity {
	var helperVec3 = new Vec3();

	override function onActivate(staticData: String, dtimeS: Float) {
		super.onActivate(staticData, dtimeS);
		// trace(staticData);
	}

	override function onStep(delta: Float, moveResult: Dynamic) {
		super.onStep(delta, moveResult);

		this.getPosFast(helperVec3);

		helperVec3.y += delta;

		this.setPos(helperVec3);

		// helperVec3.doThing();
	}

	override function getStaticData(): String {
		return "test 1234";
	}
}
