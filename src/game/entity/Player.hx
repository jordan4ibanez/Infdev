package src.game.entity;

import lua.Lua;
import src.engine.compilercode.Macros;
import src.engine.entity.ObjectProperties;
import src.engine.entity.definition.PhysicsOverride;
import src.engine.entity.definition.PlayerControl;
import src.engine.entity.helpers.EntitySerialization;
import src.engine.entity.objectref.ObjectRefBase;
import src.engine.entity.objectref.ObjectRefPlayer;
import src.engine.vector.Vec3;

private enum abstract PlayerAnimation(String) to String {
	// var PlayerAnimation = "";
	var PlayerAnimationIdle = "idle";
	var PlayerAnimationMine = "mine";
	var PlayerAnimationWalk = "walk";
	var PlayerAnimationMineWalk = "mine_walk";
	var PlayerAnimationLookPitch = "look_pitch";
	var PlayerAnimationLookYaw = "look_yaw";
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

	@:allow(src.engine.entity.helpers.PlayerHandling)
	private function new() {}

	function makeHand3D() {
		var inv = this.object.getInventory();
		// This also means that 3D hands be chambered to switch between in the hand inventory.
		inv.set_size("hand", 1);
		inv.set_stack("hand", 1, "infdev:virtual_hand_3d");
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

	function setModel(): Void {
		this.object.setProperties(new ObjectProperties()
			.setVisualSize(new Vec3(1, 1, 1))
			.setVisual(EntityVisualMesh)
			.setMesh("character.glb")
			.setTextures(["character.png"]));

		this.playAnimation(PlayerAnimationLegsStand);
		this.playAnimation(PlayerAnimationArmsIdle);
	}

	public function onActivate(staticData: String, dtimeS: Float) {
		EntitySerialization.safeDeserialize(staticData, this, Macros.getCompileTimeClass());

		this.name = this.object.getPlayerName();

		this.makeHand3D();
		this.setModel();

		this.object.setPhysicsOverride(new PhysicsOverride()
			.setGravity(1.25)
			.setJump(1.25));

		this.object.setProperties(new ObjectProperties()
			.setStepUpMode(StepUpModeRigid));

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

	function trackAnimationTimer(delta: Float): Void {
		animationTimer += delta;

		if (animationTimer >= 1.0) {
			animationTimer -= 1.0;
		}
	}

	function doPlayerAnimations(delta: Float) {
		var legStateChange = false;
		var armStateChange = false;

		// Mining.
		if (mining && !wasMining && !wasPlacing) {
			armStateChange = true;
		} else if (wasMining && !mining && !placing) {
			armStateChange = true;
		}
		// Placing.
		else if (placing && !wasPlacing && !wasMining) {
			armStateChange = true;
		} else if (wasPlacing && !placing && !mining) {
			armStateChange = true;
		}

		// Walking.
		if (walking && !wasWalking) {
			legStateChange = true;
		} else if (wasWalking && !walking) {
			legStateChange = true;
		}

		if (legStateChange) {
			if (walking) {
				playAnimation(PlayerAnimationLegsWalk);
			} else {
				playAnimation(PlayerAnimationLegsStand);
			}
		}

		// if (armStateChange) {
		// 	// trace("state change", Math.random());
		// 	if (walking) {
		// 		if (mining || placing) {
		// 			trace(1);
		// 			playAnimation(PlayerAnimationMineWalk);
		// 		} else {
		// 			trace(2);
		// 			playAnimation(PlayerAnimationWalk);
		// 		}
		// 	} else {
		// 		if (mining || placing) {
		// 			trace(3);
		// 			playAnimation(PlayerAnimationMineStand);
		// 		} else {
		// 			trace(4);
		// 			playAnimation(PlayerAnimationStand);
		// 		}
		// 	}
		// }
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
