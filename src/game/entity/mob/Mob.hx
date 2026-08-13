package src.game.entity.mob;

import src.engine.Serialize;
import src.engine.compilercode.Macros;
import src.engine.entity.LuaEntity;

private class InternalEntityData {
	public function new() {}
}

@:entityRoot
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
		Serialize.deserializeHaxeObject(staticData, this, Macros.getCompileTimeClass());
		this.object.setProperties({
			collide_with_objects: false,
			step_up_mode: StepUpModeRigid
		});

		this.enableShadow();
	}

	override function getStaticData(): String {
		return EntitySerialization.safeSerialize(this, Macros.getCompileTimeClass());
	}
}
