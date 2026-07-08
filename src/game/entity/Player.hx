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
	var PlayerAnimationArmsStand = "arms_stand";
	var PlayerAnimationArmsWalk = "arms_walk";
	var PlayerAnimationLegsStand = "legs_stand";
	var PlayerAnimationLegsWalk = "legs_walk";
	var PlayerAnimationArmsMine = "arms_mine";
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

	// Stop looking at my hackjob.
	var armsPriority = -2_147_483_648;
	var legsPriority = -2_147_483_648;

	@:allow(src.engine.entity.helpers.PlayerHandling)
	private function new() {}

	function makeHand3D() {
		var inv = this.object.getInventory();
		// This also means that 3D hands be chambered to switch between in the hand inventory.
		inv.set_size("hand", 1);
		inv.set_stack("hand", 1, "infdev:virtual_hand_3d");
	}

	inline function playAnimation(animation: PlayerAnimation, priority: Int, ?speed: Float, ?loop: Bool = true): Void {
		this.object.playAnimation(animation, {
			priority: priority,
			speed: speed,
			blend: 0.25,
			loop: loop
		});
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

		this.playAnimation(PlayerAnimationArmsStand, armsPriority);
		this.playAnimation(PlayerAnimationLegsStand, legsPriority);
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

	function doPlayerAnimations(delta: Float) {
		// Mining.
		if (mining && !wasMining && !wasPlacing) {
			this.playAnimation(PlayerAnimationArmsMine, armsPriority, 3);
			armsPriority++;
		} else if (wasMining && !mining && !placing) {
			if (walking) {
				this.playAnimation(PlayerAnimationArmsWalk, armsPriority);
			} else {
				this.playAnimation(PlayerAnimationArmsStand, armsPriority);
			}
			armsPriority++;
		}

		// Placing.
		if (placing && !wasPlacing && !wasMining) {
			this.playAnimation(PlayerAnimationArmsMine, armsPriority, 3);
			armsPriority++;
		} else if (wasPlacing && !placing && !mining) {
			if (walking) {
				this.playAnimation(PlayerAnimationArmsWalk, armsPriority);
			} else {
				this.playAnimation(PlayerAnimationArmsStand, armsPriority);
			}
			armsPriority++;
		}

		// Walking.
		if (walking && !wasWalking) {
			if (!mining) {
				this.playAnimation(PlayerAnimationArmsWalk, armsPriority);
				armsPriority++;
			} else {
				// Increase the priority to kick start it.
				this.playAnimation(PlayerAnimationArmsWalk, armsPriority);
				armsPriority++;
				this.playAnimation(PlayerAnimationArmsMine, armsPriority, 3);
				armsPriority++;
			}
			this.playAnimation(PlayerAnimationLegsWalk, legsPriority);
			legsPriority++;
		} else if (wasWalking && !walking) {
			if (!mining) {
				this.playAnimation(PlayerAnimationArmsStand, armsPriority);
				armsPriority++;
			} else {
				this.stopAnimation(PlayerAnimationArmsWalk);
			}
			this.playAnimation(PlayerAnimationLegsStand, legsPriority);
			legsPriority++;
		}
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
