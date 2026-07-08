package src.game.entity;

import lua.Lua;
import src.engine.compilercode.Macros;
import src.engine.entity.ObjectProperties;
import src.engine.entity.definition.PhysicsOverride;
import src.engine.entity.helpers.EntitySerialization;
import src.engine.entity.objectref.ObjectRefBase;
import src.engine.entity.objectref.ObjectRefPlayer;
import src.engine.vector.Vec2;
import src.engine.vector.Vec3;

final class Player {
	public var object: ObjectRefPlayer = null;

	var name: String;

	@:allow(src.engine.entity.helpers.PlayerHandling)
	private function new() {}

	function makeHand3D() {
		var inv = this.object.getInventory();
		// This also means that 3D hands be chambered to switch between in the hand inventory.
		inv.set_size("hand", 1);
		inv.set_stack("hand", 1, "infdev:virtual_hand_3d");
	}

	function setModel(): Void {
		this.object.setProperties(new ObjectProperties()
			.setVisualSize(new Vec3(1, 1, 1))
			.setVisual(EntityVisualMesh)
			.setMesh("character.b3d")
			.setTextures(["character.png"]));
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

	public function onNewPlayer(): Void {}

	// todo: I don't think moveresult is possible
	// moveResult: Dynamic
	public function onStep(delta: Float) {}

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
