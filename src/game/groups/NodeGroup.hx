package src.game.groups;

enum abstract AttachedNodeSetting(Int) to Int {
	var AttachedNodeSettingWallMounted = 1;
	var AttachedNodeSettingFaceDirOr4Dir = 2;
	var AttachedNodeSettingAlwaysToBelow = 3;
	var AttachedNodeSettingAlwaysToAbove = 4;
}

enum abstract NodeGroup(String) to String {
	var NodeGroupHandDiggable;
	var NodeGroupDirt;
	var NodeGroupSand;
	var NodeGroupStone;
	var NodeGroupCobblestone;
	var NodeGroupBrick;
	var NodeGroupGlass;
	var NodeGroupTree;
	var NodeGroupWood;
	var NodeGroupPlanks;
	var NodeGroupSoil;
	var NodeGroupPlant;
	var NodeGroupLeaves;
	var NodeGroupFarmLand;
	var NodeGroupBedrock;
	var NodeGroupLiquidSource;
	var NodeGroupLiquidFlow;
	var NodeGroupWater;
	var NodeGroupLava;

	// Specialized engine groups.
	var NodeGroupAttachedNode = "attached_node";
	var NodeGroupBouncy = "bouncy";
	var NodeGroupConnectToRaillike = "connect_to_raillike";
	// var NodeGroupDigImmediate = "dig_immediate";
	var NodeGroupDisableJump = "disable_jump";
	var NodeGroupDisableDescend = "disable_descend";
	var NodeGroupFallDamageAddPercent = "fall_damage_add_percent";
	var NodeGroupFallingNode = "falling_node";
	var NodeGroupFloat = "float";
	var NodeGroupLevel = "level";
	var NodeGroupSlippery = "slippery";
}

inline final BEDROCK: Int = 506;
