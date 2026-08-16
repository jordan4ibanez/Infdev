package src.game.entity.player;

import lua.Lua;
import src.engine.Core;
import src.engine.InvRef;
import src.engine.Serialize;
import src.engine.Tick;
import src.engine.compilercode.Macros;
import src.engine.entity.definition.PlayerControl;
import src.engine.entity.objectref.ObjectRefBase;
import src.engine.entity.objectref.ObjectRefEntity;
import src.engine.entity.objectref.ObjectRefPlayer;
import src.engine.player.PlayerInformation;
import src.engine.player.PlayerWindowInformation;
import src.engine.vector.Vec3;

// Your player is internally known as "Frobert".
// If you don't like that then get fucked.
final class Player {
	public var object: ObjectRefPlayer = null;

	var name: String;

	var noSaveRanFirstGUIUpdate = false;

	var shadowEntity: Null<ObjectRefEntity> = null;
	var animationHandler: Null<PlayerAnimationHandler> = null;
	var inventoryFormspec: Null<PlayerInventoryFormspec> = null;

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

	function disableBuiltInHud() {
		// var inv = this.object.getInventory();
		// This also means that 3D hands be chambered to switch between in the hand inventory.
		// inv.setSize("hand", 1);
		// inv.setStack("hand", 1, "infdev:stone");
		this.object.hudSetFlags({
			healthbar: false,
			wielditem: false,
			breathbar: false,
			minimap: true,
			minimap_radar: true,
			// chat: false
		});
	}

	/**
	 * Enable having a shadow under this entity.
	 */
	public function enableShadow(?size: Float): Void {
		// Stops shadows from spawning shadows.

		this.shadowEntity = Core.addEntity(this.object.getPos(), "infdev:entity_shadow", this.object.getGUID());
		// The entity may disappear immediately.
		if (this.shadowEntity != null) {
			this.shadowEntity.setAttach(this.object, "", new Vec3(0, 0, 0), new Vec3(0, 0, 0), true);
		} else {
			Core.log(LogLevelError, 'Tried to spawn entity shadow at ${this.object.getPos()} but it became null instantly.');
			return;
		}
		if (size != null) {
			this.setShadowSize(size);
		}
	}

	public function setShadowSize(size: Float): Void {
		if (this.shadowEntity == null) {
			Core.log(LogLevelError, 'Tried to set shadow size when the shadow entity doesn\'t exist. ${this.name}');
			return;
		}
		this.shadowEntity.setProperties({
			visual_size: new Vec3(size, size, size)
		});
	}

	function setModel(): Void {
		this.object.setProperties({
			visual_size: new Vec3(1, 1, 1),
			visual: EntityVisualCube,
			// mesh: "infdev_player.gltf",
			textures: ["infdev_blank_pixel.png", "infdev_blank_pixel.png", "infdev_blank_pixel.png", "infdev_blank_pixel.png", "infdev_blank_pixel.png", "infdev_blank_pixel.png"]
		});

		this.animationHandler.playAnimation(PlayerAnimationIdle);
	}

	function adjustCamera(): Void {
		var height = -0.5;
		this.object.setEyeOffset(
			new Vec3(0, height, 1.7),
			new Vec3(0, height, 0),
			new Vec3(0, height, 0));
	}

	public function getName(): String {
		return this.name;
	}

	function triggerFirstGUIUpdate(): Void {
		var windowInfo = this.getWindowInformation();
		if (windowInfo == null) {
			return;
		}
		if (windowInfo.size == null) {
			return;
		}
		this.object.setInventoryFormspec(this.inventoryFormspec.serialize());
		this.noSaveRanFirstGUIUpdate = true;
	}

	// !
	// !
	// ! Do not add any custom functions below this line!
	// !
	// !
	public function onActivate(staticData: String, dtimeS: Float) {
		Serialize.deserializeHaxeObject(staticData, this, Macros.getCompileTimeClass());

		this.name = this.object.getPlayerName();
		this.animationHandler = new PlayerAnimationHandler(this.object);

		this.disableBuiltInHud();
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

		Tick.registerOnTickEntity(this.object);

		Lua.print(this.name + " joined the game.");
	}

	public function onDeactivate(removal: Bool) {
		this.inventoryFormspec.terminate();
		// trace("on_deactivate?");
	}

	// The only time this runs is when a player leaves.
	public function getStaticData(): String {
		return Serialize.serializeHaxeObject(this, Macros.getCompileTimeClass());
	}

	public function onNewPlayer(): Void {
		// todo: fireworks and sound effect
	}

	// I don't think moveresult is possible
	// moveResult: Dynamic
	public function onStep(delta: Float) {
		this.animationHandler.doStateLogic();
		this.animationHandler.trackAnimationTimer(delta);
		this.animationHandler.doPlayerAnimations(delta);
		this.inventoryFormspec.doPlayerInventorySoundReset();

		// This is randomly sent to the server so it has to be run like this.
		if (!this.noSaveRanFirstGUIUpdate) {
			this.triggerFirstGUIUpdate();
		}
	}

	// Runs at 100 ticks per minute.
	public function onTick(): Void {
		// untyped print('${this.name} tick');
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
}
