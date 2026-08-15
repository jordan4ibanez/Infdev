package src.game.entity.player;

import src.engine.compilercode.LuaLoop;
import src.engine.entity.objectref.ObjectRefPlayer;

enum abstract PlayerAnimation(String) to String {
	// var PlayerAnimation = "";
	var PlayerAnimationIdle = "idle";
	var PlayerAnimationMine = "mine";
	var PlayerAnimationWalk = "walk";
	var PlayerAnimationMineWalk = "mine_walk";
	var PlayerAnimationLookPitch = "look_pitch";
	var PlayerAnimationLookYaw = "look_yaw";
	// Crazy animation for human mob.
	var PlayerAnimationHumanIdle = "human_idle";
	var PlayerAnimationHumanWalk = "human_walk";
}

final class PlayerAnimationHandler {
	var playerObject: ObjectRefPlayer;
	// ? Animation stuff.
	var mining: Bool;
	var wasMining: Bool;
	var placing: Bool;
	var wasPlacing: Bool;
	var walking: Bool;
	var wasWalking: Bool;
	var sneaking: Bool;
	var wasSneaking: Bool;
	var animationTimer: Float = 0.0;
	// Stop looking at my hackjob.
	var animationPriority = -2_147_483_648;
	var oldLookPitch = 0.0;

	public function new(playerObject: ObjectRefPlayer) {
		this.playerObject = playerObject;
	}

	public function playAnimation(animation: PlayerAnimation, ?speed: Float, ?loop: Bool = true): Void {
		LuaLoop.nativePairs(oldAnimName, anim, this.playerObject.getAnimations(), {
			if (oldAnimName != PlayerAnimationLookPitch && oldAnimName != PlayerAnimationLookYaw) {
				this.playerObject.stopAnimation(oldAnimName);
			}
		});

		this.playerObject.playAnimation(animation, {
			priority: animationPriority,
			speed: speed,
			start_frame: animationTimer,
			blend: 0.5,
			loop: loop
		});

		animationPriority++;
	}

	public inline function stopAnimation(animation: PlayerAnimation): Void {
		this.playerObject.stopAnimation(animation);
	}

	public inline function setAnimationSpeed(animation: PlayerAnimation, speed: Float): Void {
		this.playerObject.updateAnimation(animation, {speed: speed});
	}

	public function trackAnimationTimer(delta: Float): Void {
		animationTimer += delta;

		if (animationTimer >= 1.0) {
			animationTimer -= 1.0;
		}
	}

	public function doPlayerAnimations(delta: Float) {
		var stateChange = false;

		// Mining.
		if (mining && !wasMining && !wasPlacing) {
			stateChange = true;
		} else if (wasMining && !mining && !placing) {
			stateChange = true;
		}
		// Placing.
		else if (placing && !wasPlacing && !wasMining) {
			stateChange = true;
		} else if (wasPlacing && !placing && !mining) {
			stateChange = true;
		}
		// Walking.
		else if (walking && !wasWalking) {
			stateChange = true;
		} else if (wasWalking && !walking) {
			stateChange = true;
		}

		if (stateChange) {
			if (walking) {
				if (mining || placing) {
					// todo: play pitch animation arm.
					playAnimation(PlayerAnimationMineWalk, 1.25);
				} else {
					// todo: stop pitch animation arm.
					playAnimation(PlayerAnimationWalk, 1.25);
				}
			} else {
				if (mining || placing) {
					// todo: play pitch animation arm.
					playAnimation(PlayerAnimationMine, 1.25);
				} else {
					// todo: stop pitch animation arm.
					playAnimation(PlayerAnimationIdle);
				}
			}
		}

		var newLookPitch = this.playerObject.getLookDir().y;

		if (newLookPitch == oldLookPitch) {
			return;
		}

		var pitchAdjusted = (newLookPitch + 1) * 0.5;

		// This isn't an animation. It's magic. You're a lizard, Barry.

		this.playerObject.playAnimation(PlayerAnimationLookPitch, {
			priority: animationPriority,
			speed: 0,
			min_frame: pitchAdjusted,
			max_frame: pitchAdjusted,
			blend: 0.2,
			loop: false
		});

		oldLookPitch = newLookPitch;
	}

	public function doStateLogic(): Void {
		final control = playerObject.getPlayerControl();

		wasMining = mining;
		mining = control.dig;

		wasPlacing = placing;
		placing = control.place;

		wasWalking = walking;
		walking = control.left || control.right || control.up || control.down;

		wasSneaking = sneaking;
		sneaking = control.sneak;

		// todo: some way to support controllers dynamic range.
	}
}
