package src.game.entity;

import src.engine.entity.LuaEntity;
import src.engine.entity.ObjectProperties;

@:luantiEntity("infdev:test")
class TestEntity extends LuaEntity {
	override function onActivate(staticData: String, dtimeS: Float) {
		super.onActivate(staticData, dtimeS);

		this.object.setProperties(new ObjectProperties()
			.setVisual(EntityVisualMesh)
			.setMesh("character.glb")
			.setTextures(["character.png"]));

		this.object.playAnimation("walk", {
			speed: 1,
			priority: 1
		});

		this.object.playAnimation("mine", {
			priority: 2,
            speed: 3
		});

		// so this would be like -90 to 90 + 90 / 180
		// I think this animation may need to be inverted
		this.object.playAnimation("look_pitch", {
			speed: 0,
			min_frame: 0.7,
			max_frame: 0.7,
		});

		this.object.playAnimation("look_yaw", {
			speed: 0,
			min_frame: 0.35,
			max_frame: 0.35,
		});
	}
}
