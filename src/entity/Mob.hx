package entity;

import vector.Vec3;
import luanti_types.Core.Global;
import lua.Lua;

class Mob extends LuaEntity {
	var helper = new Vec3();

	override function onActivate(staticData: String, dtimeS: Float) {
		super.onActivate(staticData, dtimeS);
		// trace(staticData);
	}

	override function onStep(delta: Float, moveResult: Dynamic) {
		super.onStep(delta, moveResult);

		// untyped {
		// 	Lua.print(Global.dump(this.object.get_properties()));
		// }

		this.getPosFast(helper);

		helper.doThing();
	}

	override function getStaticData(): String {
		return "test 1234";
	}
}
