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

	var groupcaps: Table<String, GroupCapabilities>;

	@:native("damage_groups")
	var damageGroups: Table<String, Int>;

	@:native("punch_attack_uses")
	var punchAttackUses: Null<Int>;

	public function new() {}

	public function setFullPunchInterval() {}
}

class Blah {
	static function __init__() {
		var i = new ToolCapabilities();
		untyped __lua__("
		print(i);
		");
	}
}
