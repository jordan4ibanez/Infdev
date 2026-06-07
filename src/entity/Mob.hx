package entity;

import luanti_types.Core.Global;
import lua.Lua;

class Mob extends LuaEntity {
	override function onActivate(staticData: String, dtimeS: Float) {
		super.onActivate(staticData, dtimeS);
		// trace(staticData);
	}

	override function onStep(delta: Float, moveResult: Dynamic) {
		super.onStep(delta, moveResult);

		// untyped {
		// 	Lua.print(Global.dump(this.object.get_properties()));
		// }

		trace(this.getGUID());
	}

	override function getStaticData(): String {
		return "test 1234";
	}
}
