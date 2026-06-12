package entity;

import luantitypes.Macros;
import lua.Lua;
import luantitypes.Core;
import vector.Vec3;
import entity.objectref.ObjectRefBase;
import entity.helpers.EntitySerialization;

abstract class Mob extends LuaEntity {
	var helperVec3 = new Vec3();

	override function onActivate(staticData: String, dtimeS: Float) {
		super.onActivate(staticData, dtimeS);

		EntitySerialization.safeDeserialize(staticData, this, Macros.getCompileTimeClass());
	}

	override function onStep(delta: Float, moveResult: Dynamic) {
		super.onStep(delta, moveResult);

		// helperVec3.doThing();

		// var x = Core.getObjectsInsideRadius(this.object.getPos(), 5);

		// for (obj in x) {
		// 	Lua.print(obj);
		// 	trace(obj.getPos(), obj.getGUID(), obj.isValid());
		// }

		this.object.rightClick(this.object);
	}

	override function onRightClick(clicker: ObjectRefBase) {
		super.onRightClick(clicker);
	}

	override function getStaticData(): String {
		return EntitySerialization.safeSerialize(this, Macros.getCompileTimeClass());
	}
}
