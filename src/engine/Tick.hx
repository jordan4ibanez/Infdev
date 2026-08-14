package src.engine;

import src.engine.entity.objectref.ObjectRefBase;
import src.engine.entity.objectref.ObjectRefEntity;
import src.engine.entity.objectref.ObjectRefPlayer;

/**
 * This is literally designed the make the game feel slightly janky or predictably frustrating and allow you to manipulate things.
 * 
 * "Just set the server tickrate to blah blah"
 * 
 * This works independantly of the server so that things like animations, running, GUI, or hud animations aren't completely broken.
 */
final class Tick {
	static var counter = 0.0;
	static inline final TICK_RATE = 0.6;

	static var entities: Map<String, Bool> = new Map();

	static function deploy(): Void {
		Core.registerGlobalStep(bookKeeper);
	}

	static function bookKeeper(delta: Float): Void {
		counter += delta;
		if (counter < TICK_RATE) {
			return;
		}
		counter -= TICK_RATE;
		onTick();
	}

	static function __init__(): Void {
		deploy();
	}

	// Anything can do an on tick.
	public static function registerOnTickEntity(object: ObjectRefBase): Void {
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

	static function onTick(): Void {
		// todo: go through all the entities and run on tick.

		untyped print("tick");
	}
}
