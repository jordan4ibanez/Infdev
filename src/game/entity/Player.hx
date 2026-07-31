package src.game.entity;

import lua.Lua;
import src.engine.compilercode.Macros;
import src.engine.entity.definition.PlayerControl;
import src.engine.entity.helpers.EntitySerialization;
import src.engine.entity.objectref.ObjectRefBase;
import src.engine.entity.objectref.ObjectRefPlayer;
import src.engine.player.PlayerInformation;
import src.engine.player.PlayerWindowInformation;
import src.engine.vector.Vec3;

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

final class Player {
	public var object: ObjectRefPlayer = null;

	var name: String;
	// ? State bools.
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

	@:allow(src.engine.entity.helpers.PlayerHandling)
	private function new() {}

	public function getInformation(): PlayerInformation {
		return untyped __lua__("core.get_player_information({0})", this.name);
	}

	public function getWindowInformation(): PlayerWindowInformation {
		return untyped __lua("core.get_player_window_information({0})", this.name);
	}

	function playAnimation(animation: PlayerAnimation, ?speed: Float, ?loop: Bool = true): Void {
		this.object.playAnimation(animation, {
			priority: animationPriority,
			speed: speed,
			start_frame: animationTimer,
			blend: 0.15,
			loop: loop
		});

		animationPriority++;
	}

	inline function stopAnimation(animation: PlayerAnimation): Void {
		this.object.stopAnimation(animation);
	}

	inline function setAnimationSpeed(animation: PlayerAnimation, speed: Float): Void {
		this.object.updateAnimation(animation, {speed: speed});
	}

	inline function getControls(): PlayerControl {
		return this.object.getPlayerControl();
	}

	function makeHand3D() {
		var inv = this.object.getInventory();
		// This also means that 3D hands be chambered to switch between in the hand inventory.
		inv.set_size("hand", 1);
		inv.set_stack("hand", 1, "infdev:virtual_hand_3d");
	}

	function setModel(): Void {
		this.object.setProperties({
			visual_size: new Vec3(1, 1, 1),
			visual: EntityVisualMesh,
			mesh: "character.glb",
			textures: ["character.png"]
		});

		this.playAnimation(PlayerAnimationIdle);
	}

	function adjustCamera(): Void {
		var height = -1.4;
		this.object.setEyeOffset(
			new Vec3(),
			new Vec3(0, height, 0),
			new Vec3(0, height, 0));
	}

	function trackAnimationTimer(delta: Float): Void {
		animationTimer += delta;

		if (animationTimer >= 1.0) {
			animationTimer -= 1.0;
		}
	}

	function doPlayerAnimations(delta: Float) {
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
					playAnimation(PlayerAnimationMineWalk);
				} else {
					playAnimation(PlayerAnimationWalk);
				}
			} else {
				if (mining || placing) {
					playAnimation(PlayerAnimationMine);
				} else {
					playAnimation(PlayerAnimationIdle);
				}
			}
		}

		var newLookPitch = this.object.getLookDir().y;

		if (newLookPitch == oldLookPitch) {
			return;
		}

		var pitchAdjusted = (newLookPitch + 1) * 0.5;

		// This isn't an animation. It's magic. You're a lizard, Barry.

		this.object.playAnimation(PlayerAnimationLookPitch, {
			priority: animationPriority,
			speed: 0,
			min_frame: pitchAdjusted,
			max_frame: pitchAdjusted,
			blend: 0.2,
			loop: false
		});

		oldLookPitch = newLookPitch;
	}

	function doStateLogic(): Void {
		final control = this.getControls();

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

	// !
	// !
	// ! Do not add any custom functions below this line!
	// !
	// !
	public function onActivate(staticData: String, dtimeS: Float) {
		EntitySerialization.safeDeserialize(staticData, this, Macros.getCompileTimeClass());

		this.name = this.object.getPlayerName();

		this.makeHand3D();
		this.setModel();

		this.object.setPhysicsOverride({
			gravity: 1.25,
			jump: 1.25,
			acceleration_default: 0.45,
			acceleration_fast: 0.45,
			acceleration_air: 0.45,
		});

		this.object.setProperties({
			step_up_mode: StepUpModeRigid
		});

		this.adjustCamera();

		Lua.print(this.name + " joined the game.");
	}

	public function onDeactivate(removal: Bool) {
		// trace("on_deactivate?");
	}

	public function getStaticData(): String {
		return EntitySerialization.safeSerialize(this, Macros.getCompileTimeClass());
	}

	public function onNewPlayer(): Void {
		// todo: fireworks and sound effect
	}

	// todo: I don't think moveresult is possible
	// moveResult: Dynamic
	public function onStep(delta: Float) {
		doStateLogic();
		trackAnimationTimer(delta);
		doPlayerAnimations(delta);
	}

	public function onPunch(puncher: Null<ObjectRefBase>, timeFromLastPunch: Float, toolCapabilities: Dynamic, dir: Dynamic, damager: Int): Bool {
		trace(this.object.getPlayerName() + " got punched! OUCH");
		// Disable the default damage mechanic cause fuck that shit.
		return true;
	}

	public function onRightClick(clicker: Null<ObjectRefBase>): Void {}

	public function onHPChange(hpChange: Int, reason: Dynamic): Int {
		if (hpChange < 0) {
			trace("OUCH!");
		}
		// Do things here.
		return hpChange; // hpChange
	}

	public function onDeath(reason: Dynamic): Void {
		trace(this.object.getPlayerName() + " died, womp womp");
	}

	public function onRespawn(): Bool {
		trace(this.object.getPlayerName() + " respawn!");
		return false;
	}
}
