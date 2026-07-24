package src.game.groups;

enum abstract AttachedNode(Int) to Int {
	var AttachedNodeWallMounted = 1;
	var AttachedNodeFaceDirOr4Dir = 2;
	var AttachedNodeAlwaysToBelow = 3;
	var AttachedNodeAlwaysToAbove = 4;
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
