package src.game.entity.mob;

import lua.Math;
import src.engine.Core;
import src.engine.entity.MoveResult;
import src.engine.vector.Vec2;
import src.engine.vector.Vec3;

private enum abstract MobState(String) to String {
	var MobStateIdle;
	var MobStateWalk;
}

@:luantiEntity("infdev:human")
class Human extends Mob {
	var velocityVector: Vec3 = new Vec3();
	var drivingForce: Vec3 = new Vec3();
	var turnTimer: Float = 0;
	var yawTarget: Float = 0;
	var acceleration: Float = 3;
	var velocityTarget: Float = 4;
	var jumpAttempts: Int = 0;
	var jumpAttemptLimit: Int = cast Math.random(1, 4);
	var oldJumpPosition: Vec2 = new Vec2();

	// Stop looking at my hackjob.
	var animationPriority = -2_147_483_648;

	var state: MobState = MobStateIdle;

	function jump(): Void {
		var pos = this.object.getPos();
		if (oldJumpPosition.x == pos.x || oldJumpPosition.y == pos.z) {
			trace('trying $jumpAttempts');
			jumpAttempts++;
			if (jumpAttempts >= 2) {
				turnTimer = -1;
				jumpAttempts = 0;
				jumpAttemptLimit = cast Math.random(0, 4);
				trace("failure. turning");
			}
		} else {
			jumpAttempts = 0;
		}

		this.object.addVelocity(new Vec3(0, 5.5, 0));
		trace('jump${Math.random()}');

		oldJumpPosition.setFloats(pos.x, pos.z);
	}

	function walkLogic(delta: Float, moveResult: MoveResult): Void {
		// Do some basic "thinking processing".
		this.turnTimer -= delta;

		// I think I accidentally discovered how wolved work in the other game.
		var home = Core.getPlayerByName("singleplayer");
		if (home != null) {
			var homePos = home.getPos();
			var distance = homePos.distance(this.object.getPos());
			if (distance > 20) {
				this.object.setPos(homePos);
			}
		}

		if (moveResult.collides) {
			// untyped print("==============");
			if (moveResult.touching_ground) {
				for (collision in moveResult.collisions) {
					if (collision.axis == CollisionAxisX || collision.axis == CollisionAxisZ) {
						if (this.object.getVelocity().y == 0) {
							this.jump();
						}
					}
					// untyped print(dump(collision));
				}
			}
		}

		if (this.turnTimer > 0) {
			return;
		}

		this.turnTimer = Math.random(4, 8) + Math.random();

		// A thought has come through. Walk in a random direction.

		this.yawTarget = Math.random() * (Math.pi * 2);
	}

	inline function idleLogic(delta: Float, moveResult: MoveResult): Void {
		trace("idling");
		this.yawTarget = Math.random() * (Math.pi * 2);
		this.velocityTarget = 0;
	}

	function move(delta: Float): Void {
		// todo: this needs to smooth it with some kind of acceleration definition for the mob
		// todo: physics settings for mobs

		var targetVelocity = Core.yawToDir(this.yawTarget);
		targetVelocity.multiplyScalar(this.velocityTarget);

		var currentVelocity = this.object.getVelocity();
		currentVelocity.y = 0;

		drivingForce.setFloats(
			targetVelocity.x - currentVelocity.x,
			0,
			targetVelocity.z - currentVelocity.z
		);

		drivingForce.multiplyScalar(Math.min(1.0, this.acceleration * delta));

		this.object.addVelocity(drivingForce);
	};

	inline function doModelYawVisual(): Void {
		this.object.setYaw(yawTarget);
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

		// But things that fly or swim shouldn't get this.
		this.object.setAcceleration(new Vec3(0, -12.2625, 0));

		this.object.playAnimation("human", {
			speed: 1,
		});

		this.setSize(1, 2);
	}

	override function onStep(delta: Float, moveResult: MoveResult) {
		super.onStep(delta, moveResult);

		switch (this.state) {
			case MobStateIdle:
				this.idleLogic(delta, moveResult);
			case MobStateWalk:
				this.walkLogic(delta, moveResult);
		}

		this.move(delta);

		this.doModelYawVisual();
	}
}
