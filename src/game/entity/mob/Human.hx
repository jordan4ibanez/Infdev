package src.game.entity.mob;

import lua.Math;
import src.engine.Core;
import src.engine.vector.Vec3;

@:luantiEntity("infdev:human")
class Human extends Mob {
	var velocityVector: Vec3 = new Vec3();
	var turnTimer: Float = 0;
	var yawTarget: Float = 0;
	var acceleration: Float = 3;
	var velocityTarget: Float = 4;

	function doBasicMovementLogic(delta: Float): Void {
		// Do some basic "thinking processing".
		this.turnTimer -= delta;

		if (this.turnTimer > 0) {
			return;
		}

		this.turnTimer = Math.random(4, 8) + Math.random();

		// A thought has come through. Walk in a random direction.

		this.yawTarget = Math.random() * (Math.pi * 2);
	}

	function move(delta: Float): Void {
		// todo: this needs to smooth it with some kind of acceleration definition for the mob
		// todo: physics settings for mobs

		var targetVelocity = Core.yawToDir(this.yawTarget);
		targetVelocity.multiplyScalar(this.velocityTarget);

		var currentVelocity = this.object.getVelocity();
		currentVelocity.y = 0;

		var steeringForce = new Vec3(
			targetVelocity.x - currentVelocity.x,
			0,
			targetVelocity.z - currentVelocity.z
		);

		steeringForce.multiplyScalar(Math.min(1.0, this.acceleration * delta));

		this.object.addVelocity(steeringForce);
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

		this.object.setProperties({
			visual: EntityVisualMesh,
			mesh: "character.glb",
			textures: ["character.png"],
			makes_footstep_sound: true,
			physical: true
		});

		this.object.setAcceleration(new Vec3(0, -10, 0));

		this.object.playAnimation("human", {
			speed: 1,
		});

		this.setSize(1, 2);
	}

	override function onStep(delta: Float, moveResult: Dynamic) {
		super.onStep(delta, moveResult);

		this.doBasicMovementLogic(delta);

		this.doModelYawVisual();

		this.move(delta);
	}
}
