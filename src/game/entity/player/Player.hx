package src.game.entity.player;

import lua.Lua;
import lua.Table;
import src.engine.InvRef;
import src.engine.compilercode.Macros;
import src.engine.entity.definition.PlayerControl;
import src.engine.entity.helpers.EntitySerialization;
import src.engine.entity.objectref.ObjectRefBase;
import src.engine.entity.objectref.ObjectRefEntity;
import src.engine.entity.objectref.ObjectRefPlayer;
import src.engine.player.PlayerInformation;
import src.engine.player.PlayerWindowInformation;
import src.engine.vector.Vec3;

final class Player {
	public var object: ObjectRefPlayer = null;

	var name: String;

	var shadowEntity: Null<ObjectRefEntity> = null;
	var animationHandler: Null<PlayerAnimationHandler> = null;
	var inventoryFormspec: Null<PlayerInventoryFormspec> = null;
	var windowSizeWatcher: Null<PlayerWindowSizeWatcher> = null;

	@:allow(src.engine.entity.helpers.PlayerHandling)
	private function new() {}

	public function getInformation(): PlayerInformation {
		return untyped __lua__("core.get_player_information({0})", this.name);
	}

	public function getWindowInformation(): PlayerWindowInformation {
		return untyped __lua__("core.get_player_window_information({0})", this.name);
	}

	inline function getControls(): PlayerControl {
		return this.object.getPlayerControl();
	}

	function makeHand3D() {
		var inv = this.object.getInventory();
		// This also means that 3D hands be chambered to switch between in the hand inventory.
		inv.setSize("hand", 1);
		inv.setStack("hand", 1, "infdev:virtual_hand_3d");
	}

	function setModel(): Void {
		this.object.setProperties({
			visual_size: new Vec3(1, 1, 1),
			visual: EntityVisualMesh,
			mesh: "character.glb",
			textures: ["character.png"]
		});

		this.animationHandler.playAnimation(PlayerAnimationIdle);
	}

	function adjustCamera(): Void {
		var height = -1.4;
		this.object.setEyeOffset(
			new Vec3(),
			new Vec3(0, height, 0),
			new Vec3(0, height, 0));
	}

	public function getName(): String {
		return this.name;
	}

	// !
	// !
	// ! Do not add any custom functions below this line!
	// !
	// !
	public function onActivate(staticData: String, dtimeS: Float) {
		EntitySerialization.safeDeserialize(staticData, this, Macros.getCompileTimeClass());

		this.name = this.object.getPlayerName();
		this.animationHandler = new PlayerAnimationHandler(this.object);
		this.windowSizeWatcher = new PlayerWindowSizeWatcher(this.object);

		this.makeHand3D();
		this.setModel();

		this.object.setPhysicsOverride({
			gravity: 1.25,
			jump: 1.25,
			acceleration_default: 0.45,
			acceleration_fast: 0.45,
			acceleration_air: 0.45,
			liquid_fluidity: 1.65,
		});

		this.object.setProperties({
			step_up_mode: StepUpModeRigid
		});

		var inv: InvRef = this.object.getInventory();
		// This is designed so you can have HUGE inventories
		inv.setSize("main", 12 * 5);

		this.adjustCamera();

		this.inventoryFormspec = new PlayerInventoryFormspec(this.object);

		this.object.setInventoryFormspec(this.inventoryFormspec.serialize());

		Lua.print(this.name + " joined the game.");
	}

	public function onDeactivate(removal: Bool) {
		// trace("on_deactivate?");
	}

	// The only time this runs is when a player leaves.
	public function getStaticData(): String {
		// These are manual memory management to get rid of the object reference.
		this.animationHandler.terminate();
		this.inventoryFormspec.terminate();
		this.windowSizeWatcher.terminate();
		return EntitySerialization.safeSerialize(this, Macros.getCompileTimeClass());
	}

	public function onNewPlayer(): Void {
		// todo: fireworks and sound effect
	}

	// I don't think moveresult is possible
	// moveResult: Dynamic
	public function onStep(delta: Float) {
		this.windowSizeWatcher.update(delta);
		this.animationHandler.doStateLogic();
		this.animationHandler.trackAnimationTimer(delta);
		this.animationHandler.doPlayerAnimations(delta);
	}

	public function onPunch(puncher: Null<ObjectRefBase>, timeFromLastPunch: Float, toolCapabilities: Dynamic, dir: Dynamic, damager: Int): Bool {
		trace(this.object.getPlayerName() + " got punched! OUCH");
		// Disable the default damage mechanic cause fuck that shit.
		return true;
	}

	public function onRightClick(clicker: Null<ObjectRefBase>): Void {}

	// todo: this needs to be handled completely custom, do not use the in game hp api.
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

	public function onReceiveFields(formName: String, fields: Table<String, String>): Void {
		switch (formName) {
			case "":
				this.inventoryFormspec.process(fields);

			default:
		}
	}

	@:allow(src.game.entity.player.PlayerWindowSizeWatcher)
	function onWindowSizeChange(): Void {
		this.inventoryFormspec.updateScaling();
	}
}
