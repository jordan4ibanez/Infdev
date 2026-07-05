package src.game.groups;

enum abstract NodeGroup(String) to String {
	var NodeGroupHandDiggable;
	var NodeGroupDirt;
	var NodeGroupSand;
	var NodeGroupStone;
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
}

inline final BEDROCK: Int = 506;
