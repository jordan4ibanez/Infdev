package definition;

import haxe.DynamicAccess;
import lua.Table;

final class GroupCapabilities {
	var maxlevel = 0;
	var uses = 20;
	var times: Table<Int, Float>;

	public function new() {}
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

	public function addGroupCaps(group: String, groupCaps: GroupCapabilities): ToolCapabilities {
		if (this.groupCaps == null) {
			this.groupCaps = new DynamicAccess();
		}
		this.groupCaps["test"] = new GroupCapabilities();
		return this;
	}
}

class Blah {
	static function __init__() {
		var i = new ToolCapabilities()
			.setFullPunchInterval(5.0)
			.setMaxDropLevel(3)
			.addGroupCaps("test",
				new GroupCapabilities());
		untyped __lua__("
		print(i);
		");
	}
}
