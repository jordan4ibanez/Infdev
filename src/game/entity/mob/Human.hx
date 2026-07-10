package src.game.entity.mob;

import lua.Math;
import src.engine.entity.ObjectProperties;
import src.engine.vector.Vec3;

@:luantiEntity("infdev:human")
class Human extends Mob {
	var velocityVector = new Vec3();

	override function onActivate(staticData: String, dtimeS: Float) {
		super.onActivate(staticData, dtimeS);

		this.object.setProperties(new ObjectProperties()
			.setVisual(EntityVisualMesh)
			.setMesh("character.glb")
			.setTextures(["character.png"])
			.setMakesFootstepSound(true)
			.setPhysical(true));

		this.object.setAcceleration(new Vec3(0, -10, 0));

		this.object.playAnimation("human", {
			speed: 1,
		});
	}

	override function onStep(delta: Float, moveResult: Dynamic) {
		super.onStep(delta, moveResult);

		velocityVector.x = Math.random() * Math.random(-1, 1);
		velocityVector.z = Math.random() * Math.random(-1, 1);
		this.object.addVelocity(velocityVector);

		var vel = this.object.getVelocity();

		var yaw = untyped __lua__("core.dir_to_yaw(vel)");

		this.object.setYaw(yaw);
	}
}
