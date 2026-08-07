package src.game.entity.player;

import src.engine.entity.objectref.ObjectRefPlayer;
import src.engine.vector.Vec2;

final class PlayerWindowSizeWatcher {
	var playerObject: ObjectRefPlayer;
	var size: Vec2;

	public function new(playerObject: ObjectRefPlayer) {
		this.playerObject = playerObject;
	}
}
