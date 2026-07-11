package src.game.entity.mob;

import lua.Lua;
import lua.Math;
import src.engine.Core;
import src.engine.entity.ObjectProperties;
import src.engine.vector.Vec3;

@:luantiEntity("infdev:human")
class Human extends Mob {
	var velocityVector: Vec3 = new Vec3();
	var turnTimer: Float = 0;
	var yawTarget: Float = 0;

	function doBasicMovementLogic(delta: Float): Void {
		// Do some basic "thinking processing".
		turnTimer -= delta;

		Lua.print(turnTimer);

		if (turnTimer > 0) {
			return;
		}

		turnTimer = Math.random(2, 10) + Math.random();

		// A thought has come through. Walk in a random direction.

		velocityVector.x = Math.random() * Math.random(-1, 1);
		velocityVector.z = Math.random() * Math.random(-1, 1);
		this.object.addVelocity(velocityVector);
	}

	function doModelYawVisual(): Void {
		var vel = this.object.getVelocity();

		var yaw = Core.dirToYaw(vel);

		this.object.setYaw(yaw);
	}

	override function setHP(hp: Int) {
		trace('The HP of human ${this.object.getGUID()} is now $hp');
		this.hp = hp;
	}

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

		this.doBasicMovementLogic(delta);

		this.doModelYawVisual();
	}
}
