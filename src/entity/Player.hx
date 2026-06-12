package entity;

import entity.objectref.ObjectRefPlayer;
import luantitypes.Macros;
import entity.EntitySerialization;

final class Player {
	public var object: ObjectRefPlayer = null;

	var iAmCoolVar = 5;
	var totalTime = 0;

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
}
