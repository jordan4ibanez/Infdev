package definition;

import lua.Table;
import haxe.DynamicAccess;

final class GroupCapabilities {
	@:native("maxlevel")
	var maxLevel: Null<Int>;
	var uses: Null<Int>;
	var times: Table<Int, Float>;

	public function new() {}

	public function setMaxLevel(maxLevel: Int): GroupCapabilities {
		this.maxLevel = maxLevel;
		return this;
	}

	public function setUses(uses: Int): GroupCapabilities {
		this.uses = uses;
		return this;
	}

	/**
	 * This one is easy mode.
	 */
	public function setTimesFromArray(times: Array<Float>): GroupCapabilities {
		this.times = Table.create();
		for (index => value in times) {
			this.times[index + 1] = value;
		}
		return this;
	}

	/**
	 * This one is when you need to be specific. Or maybe you need custom times.
	 * .setTimesFromMap([
	 *    1 => 3.90,
	 *    2 => 4.60,
	 *    3 => 42.34,
	 *    4 => 5243.9
	 * ])
	 */
	public function setTimesFromMap(times: Map<Int, Float>): GroupCapabilities {
		this.times = Table.create();
		for (index => value in times) {
			this.times[index] = value;
		}
		return this;
	}
}

final class ToolCapabilities {
	@:native("full_punch_interval")
	var fullPunchInterval: Null<Float>;

	@:native("max_drop_level")
	var maxDropLevel: Null<Int>;

	@:native("groupcaps")
	var groupCaps: DynamicAccess<GroupCapabilities>;

	@:native("damage_groups")
	var damageGroups: DynamicAccess<Int>;

	@:native("punch_attack_uses")
	var punchAttackUses: Null<Int>;

	public function new() {}

	// Uses builder pattern.

	public function setFullPunchInterval(fullPunchInterval: Float): ToolCapabilities {
		this.fullPunchInterval = fullPunchInterval;
		return this;
	}

	public function setMaxDropLevel(maxDropLevel: Int): ToolCapabilities {
		this.maxDropLevel = maxDropLevel;
		return this;
	}

	public function addGroupCap(group: String, groupCap: GroupCapabilities): ToolCapabilities {
		if (this.groupCaps == null) {
			this.groupCaps = new DynamicAccess();
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
