package src.game.entity.player;

import src.engine.entity.objectref.ObjectRefPlayer;
import src.engine.vector.Vec2;

final class PlayerWindowSizeWatcher {
	var playerObject: ObjectRefPlayer;
	var size: Vec2 = new Vec2(0, 0);
	var timer: Float = 0.0;

	// Only update every second because how often is the player going to be scaling the window.
	static inline final UPDATE_INTERVAL = 1.0;

	public function new(playerObject: ObjectRefPlayer) {
		this.playerObject = playerObject;
	}

	public function update(delta: Float): Void {
		this.timer += delta;
		if (this.timer < UPDATE_INTERVAL) {
			return;
		}
		this.timer -= UPDATE_INTERVAL;
		var newSize = playerObject.getPlayerLuaEntity().getWindowInformation().size;
		if (this.size != newSize) {
			this.playerObject.getPlayerLuaEntity().onWindowSizeChange();
		}
		this.size = newSize;
	}
}
