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
	var NodeGroupFarmLand;
	var NodeGroupBedrock;
	var NodeGroupLiquidSource;
	var NodeGroupLiquidFlow;
	var NodeGroupWater;
	var NodeGroupLava;

	// Specialized.
	var NodeGroupAttachedNode;
}

inline final BEDROCK: Int = 506;
