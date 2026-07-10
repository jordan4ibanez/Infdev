package src.game.entity;

import src.engine.entity.LuaEntity;
import src.engine.entity.ObjectProperties;

@:luantiEntity("infdev:human")
class Human extends LuaEntity {
	override function onActivate(staticData: String, dtimeS: Float) {
		super.onActivate(staticData, dtimeS);

		this.object.setProperties(new ObjectProperties()
			.setVisual(EntityVisualMesh)
			.setMesh("character.glb")
			.setTextures(["character.png"])
			.setMakesFootstepSound(true)
			.setAutomaticFaceMovementDir(1.0));

		this.object.playAnimation("human", {
			speed: 1,
		});
	}
}
