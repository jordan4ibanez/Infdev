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

	static var entityRemovalQueue: Array<String> = [];
	static var entities: Map<String, ObjectRefBase> = new Map();

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
				// untyped __lua__('print(dump(core.objects_by_guid))', guid);
				// untyped print('Entity ${guid} which is entity ${(cast object : ObjectRefEntity).getLuaEntity().name} already registered to do onTick.');
				throw 'Entity ${guid} which is entity ${(cast object : ObjectRefEntity).getLuaEntity().name} already registered to do onTick.';
			}
		}
		entities.set(guid, object);
	}

	static function onTick(): Void {
		// Run onTick for all entities in this and find ones that don't exist.
		for (guid => entity in entities) {
			if (entity == null || !entity.isValid()) {
				entityRemovalQueue.push(guid);
				continue;
			}
			if (entity.isPlayer()) {
				(cast entity : ObjectRefPlayer).getPlayerLuaEntity().onTick();
			} else {
				(cast entity : ObjectRefEntity).getLuaEntity().onTick();
			}
		}
		// Clear out old entities that no longer exist.
		if (entityRemovalQueue.length > 0) {
			for (guid in entityRemovalQueue) {
				entities.remove(guid);
			}
			entityRemovalQueue = [];
		}
	}
}
