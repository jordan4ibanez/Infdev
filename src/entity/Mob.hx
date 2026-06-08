package entity;

import lua.Lua;
import luanti_types.Core;
import vector.Vec3;

abstract class Mob extends LuaEntity {
	var helperVec3 = new Vec3();

	override function onActivate(staticData: String, dtimeS: Float) {
		super.onActivate(staticData, dtimeS);
		// trace(staticData);
	}

	override function onStep(delta: Float, moveResult: Dynamic) {
		super.onStep(delta, moveResult);

		// helperVec3.doThing();

		var x = Core.getObjectsInsideRadius(this.object.getPos(), 5);

		for (obj in x) {
			Lua.print(obj);
			trace(obj.getPos());
		}
	}

	override function getStaticData(): String {
		return "test 1234";
	}
}
