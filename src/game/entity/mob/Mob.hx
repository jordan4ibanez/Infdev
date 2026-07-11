package src.game.entity.mob;

import src.engine.entity.LuaEntity;

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
}
