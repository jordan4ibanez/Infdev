package src.game.entity;

import src.engine.entity.LuaEntity;
import src.engine.entity.ObjectProperties;

@:luantiEntity("infdev:test")
class TestEntity extends LuaEntity {
	override function onActivate(staticData: String, dtimeS: Float) {
		super.onActivate(staticData, dtimeS);

		this.object.setProperties(new ObjectProperties()
			.setVisual(EntityVisualMesh)
			.setMesh("character.glb"));

		this.object.playAnimation("walk", {speed: 20});
	}
}
