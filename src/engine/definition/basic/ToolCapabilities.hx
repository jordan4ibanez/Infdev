package src.engine.definition.basic;

import haxe.DynamicAccess;
import src.engine.compilercode.LuaMap;
import src.engine.definition.NodeDefinition.MAX_NODE_LEVEL;
import src.game.groups.NodeGroup;

// todo: these need getters.

/**
 * Basically this makes it so a thing can cut down anything in any group up to the MAX_LEVEL global.
 * It flips the way the game engine originally functions where you can now cut down anything, but the node
 * decides if you get the thing.
 */
final class GroupCapabilities {
	@:native("maxlevel")
	var maxLevel: Null<Int>;
	var uses: Null<Int>;
	var times: LuaMap<Int, Float>;

	/**
	 * Create a new group capabilities table.
	 * @param baseTime The base mining time of level 1. Each level up from this will add additional time defined in increment. If it goes above maxLevel it then adds double this to each level from that point forward on top of the regular increment.
	 * @param increment The increment of the time it takes to mine things past level 1. If it goes above maxLevel it takes a lot longer.
	 * @param maxLevel The max level of the node which this tool is supposed to mine.
	 * @param uses The number of uses this tool has before it breaks.
	 * @param customValues A map of custom times which overrides the automated values. This can be used to do cool custom behavior.
	 */
	public function new(
		baseTime: Float,
		increment: Float,
		maxLevel: Int,
		uses: Int,
		?customValues: Map<Int, Float>) {
		this.times = new LuaMap();

		final minRange = 1;
		final maxRange = MAX_NODE_LEVEL + 1;

		var currentTime = baseTime;

		for (i in minRange...maxRange) {
			this.times[i] = currentTime;

			// It takes a lot longer if you've exceeded the max level of your item.
			// But only if it's max level is above 0. (excludes the hand)
			if (maxLevel > 0 && i > maxLevel) {
				currentTime += increment * 2.0;
			}
			currentTime += increment;
		}

		// Custom values overwrite generated values.
		if (customValues != null) {
			for (k => v in customValues) {
				this.times[k] = v;
			}
		}

		this.maxLevel = maxLevel;
		this.uses = uses;
	}
}

final class ToolCapabilities {
	@:native("full_punch_interval")
	var fullPunchInterval: Null<Float>;

	@:native("max_drop_level")
	var maxDropLevel: Null<Int>;

	@:native("groupcaps")
	var groupCaps: LuaMap<NodeGroup, GroupCapabilities>;

	@:native("damage_groups")
	var damageGroups: DynamicAccess<Int>;

	@:native("punch_attack_uses")
	var punchAttackUses: Null<Int>;

	public function new() {
		this.fullPunchInterval = 0.0;
	}

	// Uses builder pattern.
	// public function setFullPunchInterval(fullPunchInterval: Float): ToolCapabilities {
	// 	this.fullPunchInterval = fullPunchInterval;
	// 	return this;
	// }

	public function setMaxDropLevel(maxDropLevel: Int): ToolCapabilities {
		this.maxDropLevel = maxDropLevel;
		return this;
	}

	public function addGroupCap(group: NodeGroup, groupCap: GroupCapabilities): ToolCapabilities {
		if (this.groupCaps == null) {
			this.groupCaps = new LuaMap();
		}
		this.groupCaps[group] = groupCap;
		return this;
	}

	public function addDamageGroup(group: String, damage: Int): ToolCapabilities {
		if (this.damageGroups == null) {
			this.damageGroups = new DynamicAccess();
		}
		this.damageGroups[group] = damage;
		return this;
	}

	public function setPunchAttackUses(uses: Int): ToolCapabilities {
		this.punchAttackUses = uses;
		return this;
	}
}

// class Blah {
// 	static function __init__() {
// 		var i = new ToolCapabilities()
// 			.setFullPunchInterval(5.0)
// 			.setMaxDropLevel(3)
// 			.addGroupCap("test",
// 				new GroupCapabilities()
// 					.setMaxLevel(20)
// 					.setTimesFromArray([3.90, 4.69, 42.34, 5243.9])
// 					.setTimesFromMap([
// 						1 => 3.90,
// 						2 => 4.69,
// 						3 => 42.34,
// 						4 => 5243.9
// 					]))
// 			.addDamageGroup("flarp", 5000) // Very dangerous flarp.
// 			.setPunchAttackUses(55);
// 		untyped __lua__("
// 		print(i);
// 		");
// 	}
// }
