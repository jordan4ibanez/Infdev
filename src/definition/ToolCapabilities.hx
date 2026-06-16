package definition;

import lua.Table;

final class GroupCapabilities {
	public var maxlevel = 0;
	public var uses = 20;
	public var times: Table<Int, Float>;
}

final class ToolCapabilities {
	@:native("full_punch_interval")
	public var fullPunchInterval: Float = 1.0;

	@:native("max_drop_level")
	public var maxDropLevel: Int = 0;

	public var groupcaps: Table<String, GroupCapabilities>;

	@:native("damage_groups")
	public var damageGroups: Table<String, Int>;

	@:native("punch_attack_uses")
	public var punchAttackUses: Null<Int>;
}
