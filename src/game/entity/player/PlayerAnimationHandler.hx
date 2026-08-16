package src.game.entity.player;

import src.engine.compilercode.LuaLoop;
import src.engine.compilercode.Macros;
import src.engine.entity.LuaEntity;
import src.engine.entity.objectref.ObjectRefPlayer;
import src.engine.vector.Vec3;

@:register("infdev:player_first_person_model")
final class PlayerFirstPersonModel extends LuaEntity {
	var player: Null<ObjectRefPlayer>;

	public function setPlayer(player: ObjectRefPlayer): Void {
		this.player = player;
	}

	override function onActivate(staticData: String, dtimeS: Float) {
		Macros.entityPatch();
		super.onActivate(staticData, dtimeS);

		this.object.setProperties({
			visual_size: new Vec3(1, 1, 1),
			visual: EntityVisualMesh,
			mesh: "infdev_player.gltf",
			textures: ["infdev_player.png"]
		});
	}
}

enum abstract PlayerAnimation(String) to String {
	// var PlayerAnimation = "";
	var PlayerAnimationIdle = "idle";
	var PlayerAnimationMine = "mine";
	var PlayerAnimationWalk = "walk";
	var PlayerAnimationMineWalk = "mine_walk";
	var PlayerAnimationLookPitch = "look_pitch";
	var PlayerAnimationLookYaw = "look_yaw";
	var PlayerAnimationArmPitch = "arm_pitch";
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

	var armPitchEnabled = true;

	public function new(playerObject: ObjectRefPlayer) {
		this.playerObject = playerObject;
	}

	public function playAnimation(animation: PlayerAnimation, ?speed: Float, ?loop: Bool = true): Void {
		LuaLoop.nativePairs(oldAnimName, anim, this.playerObject.getAnimations(), {
			if (oldAnimName != PlayerAnimationLookPitch
				&& oldAnimName != PlayerAnimationLookYaw
				&& oldAnimName != PlayerAnimationArmPitch) {
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

		var oldState = this.armPitchEnabled;

		if (stateChange) {
			if (walking) {
				if (mining || placing) {
					this.armPitchEnabled = true;
					playAnimation(PlayerAnimationMineWalk, 1.25);
				} else {
					this.armPitchEnabled = false;
					playAnimation(PlayerAnimationWalk, 1.25);
				}
			} else {
				if (mining || placing) {
					this.armPitchEnabled = true;
					playAnimation(PlayerAnimationMine, 1.25);
				} else {
					this.armPitchEnabled = false;
					playAnimation(PlayerAnimationIdle);
				}
			}
		}

		var updateArmPitch = oldState != this.armPitchEnabled;

		var newLookPitch = this.playerObject.getLookDir().y;

		if (newLookPitch == oldLookPitch && !updateArmPitch) {
			return;
		}

		var pitchAdjusted = (newLookPitch + 1) * 0.5;

		// This isn't an animation. It's magic. You're a lizard, Barry.

		if (this.armPitchEnabled) {
			this.playerObject.playAnimation(PlayerAnimationArmPitch, {
				priority: animationPriority,
				speed: 0,
				min_frame: pitchAdjusted,
				max_frame: pitchAdjusted,
				blend: 0.2,
				loop: false
			});
		}

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
