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
		this.turnTimer -= delta;

		Lua.print(this.turnTimer);

		if (this.turnTimer > 0) {
			return;
		}

		this.turnTimer = Math.random(2, 10) + Math.random();

		// A thought has come through. Walk in a random direction.

		this.yawTarget = Math.random() * (Math.pi * 2);

		// velocityVector.x = Math.random() * Math.random(-1, 1);
		// velocityVector.z = Math.random() * Math.random(-1, 1);
		// this.object.addVelocity(velocityVector);
	}

	function move(delta: Float): Void {
		// todo: this needs to smooth it with some kind of acceleration definition for the mob
		// todo: physics settings for mobs
		var dir = Core.yawToDir(this.yawTarget);

		this.object.addVelocity(velocityVector);
	};

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

		this.move(delta);
	}
}
