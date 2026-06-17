package definition;

import lua.Table;

final class GroupCapabilities {
	var maxlevel = 0;
	var uses = 20;
	var times: Table<Int, Float>;
}

final class ToolCapabilities {
	@:native("full_punch_interval")
	var fullPunchInterval: Float = 1.0;

	@:native("max_drop_level")
	var maxDropLevel: Int = 0;

	@:native("groupcaps")
	var groupCaps: DynamicAccess<GroupCapabilities>;

	@:native("damage_groups")
	var damageGroups: Table<String, Int>;

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
}

class Blah {
	static function __init__() {
		var i = new ToolCapabilities()
			.setFullPunchInterval(5.0)
			.setMaxDropLevel(3);
		untyped __lua__("
		print(i);
		");
	}
}
