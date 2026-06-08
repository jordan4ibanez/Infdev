package entity;

import luanti_types.Core;
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

		// helperVec3.doThing();

		var x = Core.getObjectsInsideRadius(this.getPos(), 5);

		for (obj in x) {
			Lua.print(obj);
			obj.getPos().doThing();
		}
	}

	override function getStaticData(): String {
		return "test 1234";
	}
}
