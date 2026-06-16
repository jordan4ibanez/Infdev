package definition;

import lua.Table;

final class GroupCapabilities {
	var maxlevel = 0;
	var uses = 20;
	var times: Table<Int, Float>;
}

final class ToolCapabilities {
	@:native("full_punch_interval")
	var _fullPunchInterval: Float = 1.0;

	@:native("max_drop_level")
	var _maxDropLevel: Int = 0;

	@:native("groupcaps")
	var _groupcaps: Table<String, GroupCapabilities>;

	@:native("damage_groups")
	var __damageGroups: Table<String, Int>;

	@:native("punch_attack_uses")
	var _punchAttackUses: Null<Int>;

	public function new() {}

	// Uses builder pattern.

	public function fullPunchInterval(fullPunchInterval: Float): ToolCapabilities {
		this._fullPunchInterval = fullPunchInterval;
		return this;
	}
}

class Blah {
	static function __init__() {
		var i = new ToolCapabilities()
			.fullPunchInterval(5.0);
		untyped __lua__("
		print(i);
		");
	}
}
