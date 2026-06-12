package entity;

import entity.objectref.ObjectRefBase;
import entity.objectref.ObjectRefPlayer;
import luantitypes.Macros;
import entity.EntitySerialization;

final class Player {
	public var object: ObjectRefPlayer = null;

	var iAmCoolVar = 5;
	var totalTime: Float = 0;

	@:allow(entity.helpers.PlayerHandling)
	private function new() {}

	public function onActivate(staticData: String, dtimeS: Float) {
		EntitySerialization.safeDeserialize(staticData, this, Macros.getCompileTimeClass());
		trace(this.object.getBreath());
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
	public function onStep(delta: Float) {
		this.totalTime += delta;

		trace(totalTime);
	}

	public function onPunch(puncher: Null<ObjectRefBase>, timeFromLastPunch: Float, toolCapabilities: Dynamic, dir: Dynamic, damager: Int): Bool {
		trace(this.object.getPlayerName() + " got punched! OUCH");
		// Disable the default damage mechanic cause fuck that shit.
		return true;
	}

	public function onRightClick(clicker: Null<ObjectRefBase>): Void {}

	// todo: on HP Change
	// todo: on Die Player
	// todo: on respawn player
}
