package src.game.entity.mob;

import lua.Math;
import src.engine.Core;
import src.engine.entity.MoveResult;
import src.engine.vector.Vec2;
import src.engine.vector.Vec3;
import src.game.entity.Player.PlayerAnimation;

@:build(src.engine.compilercode.EnumMacro.decorateValidator())
private enum abstract MobState(String) to String {
	var MobStateIdle;
	var MobStateWalk;
}

private final stateAnimationDictionary: Map<MobState, PlayerAnimation> = [
	MobStateIdle => PlayerAnimationHumanIdle,
	MobStateWalk => PlayerAnimationHumanWalk,
];

@:luantiEntity("infdev:human")
class Human extends Mob {
	var velocityVector: Vec3 = new Vec3();
	var drivingForce: Vec3 = new Vec3();
	var stateTimer: Float = 0;
	var yawTarget: Float = 0;
	var acceleration: Float = 3;
	var velocityTarget: Float = 4;
	var jumpAttempts: Int = 0;
	var jumpAttemptLimit: Int = cast Math.random(1, 4);
	var oldJumpPosition: Vec2 = new Vec2();
	var turnSpeed = 5;
	var runningLogic = true;
	var ranLogic = false;

	var currentAnimation: PlayerAnimation;

	// Stop looking at my hackjob.
	var animationPriority = -2_147_483_648;

	var state: MobState = MobStateIdle;

	function changeState(newState: MobState): Void {
		this.state = newState;

		var anim = stateAnimationDictionary[newState];

		if (this.currentAnimation == anim) {
			return;
		}

		this.object.playAnimation(anim, {
			priority: animationPriority,
			blend: 0.25,
		});
		this.currentAnimation = anim;
		this.animationPriority++;
	}

	/**
	 * Randomly changes the state.
	 * @return Bool Returns true if state changed.
	 */
	function randomizeState(): Void {
		// trace(this.performingState);

		if (this.runningLogic) {
			return;
		}

		this.ranLogic = false;

		// trace("===RESET===", Math.random(), runningLogic);

		// Flip a coin and maybe it'll change state.
		if (Math.random() > 0.5) {
			// Maybe it'll be the same state. Who knows!
			this.changeState(cast MobState.all[Std.random(MobState.all.length)]);

			trace(this.state);
		}
	}

	/**
	 * A very basic optimization for mobs.
	 * If the state timer is above 0 or ranLogic is true it will return true.
	 * If your state timer is less than or equal to 0 this will set runningLogic to false.
	 * This is to trigger an initial cycle of the state logic.
	 * 
	 * ! Your initialization code should go under this. And call didInitCode() after it!
	 * @return Bool If the state intialization already ran.
	 */
	function initAlreadyRan(): Bool {
		if (this.stateTimer > 0) {
			if (this.ranLogic) {
				return true;
			}
		} else {
			this.runningLogic = false;
		}
		// And this catches an attempted second run and prevents weird double behavior.
		if (this.ranLogic) {
			return true;
		}
		return false;
	}

	function didInitCode(): Void {
		// Tell the logic director it is running.
		this.runningLogic = true;
		this.ranLogic = true;
	}

	function jump(): Void {
		var pos = this.object.getPos();
		if (oldJumpPosition.x == pos.x || oldJumpPosition.y == pos.z) {
			// trace('trying $jumpAttempts');
			jumpAttempts++;
			if (jumpAttempts >= 2) {
				stateTimer = -1;
				jumpAttempts = 0;
				jumpAttemptLimit = cast Math.random(0, 4);
				// trace("failure. turning");
			}
		} else {
			jumpAttempts = 0;
		}

		this.object.addVelocity(new Vec3(0, 6.5, 0));
		// trace('jump${Math.random()}');

		oldJumpPosition.setFloats(pos.x, pos.z);
	}

	function walkLogic(delta: Float, moveResult: MoveResult): Void {
		// Do some basic "thinking processing".
		this.stateTimer -= delta;

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

		if (this.initAlreadyRan()) {
			return;
		}

		this.stateTimer = Math.random(4, 8) + Math.random();

		this.acceleration = 3;

		// A thought has come through. Walk in a random direction.

		// trace("walking", Math.random());

		this.yawTarget = Math.random() * (Math.pi * 2);
		this.velocityTarget = 4;

		this.didInitCode();
	}

	function idleLogic(delta: Float, moveResult: MoveResult): Void {
		// Do some basic "thinking processing".
		this.stateTimer -= delta;

		if (this.initAlreadyRan()) {
			return;
		}

		this.turnSpeed = cast Math.random(3, 5);

		this.acceleration = 6;

		this.stateTimer = Math.random(0, 4) + Math.random();

		// trace("idling", Math.random());
		this.yawTarget = Math.random() * (Math.pi * 2);
		this.velocityTarget = 0;

		this.didInitCode();
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

	function teleportToPlayer(): Void {
		// I think I accidentally discovered how wolved work in the other game.
		var home = Core.getPlayerByName("singleplayer");
		if (home == null) {
			return;
		}
		var homePos = home.getPos();
		var distance = homePos.distance(this.object.getPos());
		if (distance > 20) {
			this.object.setPos(homePos);
		}
	}

	inline function doModelYawVisual(delta: Float): Void {
		// "Smoothly" rotates the mob. This was AI generated but it needed to be overhauled.
		var yaw = this.object.getYaw();

		var diff = this.yawTarget - yaw;

		while (diff > Math.PI) {
			diff -= Math.PI * 2;
		}
		while (diff < -Math.PI) {
			diff += Math.PI * 2;
		}

		var step = turnSpeed * delta;

		if (Math.abs(diff) <= step) {
			yaw = this.yawTarget;
		} else {
			yaw += (diff > 0) ? step : -step;
		}

		yaw = (yaw + Math.PI * 2) % (Math.PI * 2);

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

		// But things that fly or swim shouldn't get this.
		this.object.setAcceleration(new Vec3(0, -12.2625, 0));

		// this.object.playAnimation("human", {
		// 	speed: 1,
		// 	priority: animationPriority
		// });
		// animationPriority++;

		this.setSize(1, 2);

		this.changeState(MobStateIdle);
	}

	override function onStep(delta: Float, moveResult: MoveResult) {
		super.onStep(delta, moveResult);

		switch (this.state) {
			case MobStateIdle:
				this.idleLogic(delta, moveResult);
			case MobStateWalk:
				this.walkLogic(delta, moveResult);
		}

		this.randomizeState();

		this.move(delta);

		this.teleportToPlayer();

		this.doModelYawVisual(delta);
	}
}
