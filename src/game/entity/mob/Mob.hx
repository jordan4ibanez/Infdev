package src.game.entity.mob;

import src.engine.compilercode.Macros;
import src.engine.entity.LuaEntity;
import src.engine.entity.ObjectProperties;
import src.engine.entity.helpers.EntitySerialization;

private class InternalEntityData {
	public function new() {}
}

abstract class Mob extends LuaEntity {
	private var hp: Int = 20;

	public function getHP(): Int {
		return hp;
	}

	public function setHP(hp: Int): Void {
		this.hp = hp;
	}

	override function onActivate(staticData: String, dtimeS: Float) {
		super.onActivate(staticData, dtimeS);
		EntitySerialization.safeDeserialize(staticData, this, Macros.getCompileTimeClass());
		this.object.setProperties(new ObjectProperties()
			.setCollideWithObjects(false));
	}

	override function getStaticData(): String {
		return EntitySerialization.safeSerialize(this, Macros.getCompileTimeClass());
	}
}
