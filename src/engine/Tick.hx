package src.engine;

import src.engine.entity.objectref.ObjectRefBase;
import src.engine.entity.objectref.ObjectRefEntity;
import src.engine.entity.objectref.ObjectRefPlayer;

final class Tick {
	static var counter = 0.0;
	static inline final tickRate = 0.5;

	static var entities: Map<String, Bool> = new Map();

	// Anything can do an on tick.
	public static function registerTickEntity(object: ObjectRefBase): Void {
		final guid = object.getGUID();
		if (entities.exists(object.getGUID())) {
			if (object.isPlayer()) {
				throw 'Entity ${guid} which is player ${(cast object : ObjectRefPlayer).getPlayerName()} already registered to do onTick.';
			} else {
				throw 'Entity ${guid} which is entity ${(cast object : ObjectRefEntity).getLuaEntity().name} already registered to do onTick.';
			}
		}
		entities.set(guid, true);
	}
}
