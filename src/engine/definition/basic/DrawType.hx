package engine.definition.basic;

enum abstract DrawType(String) to String {
	var DrawTypeNormal = "normal";
	var DrawTypeAirLike = "airlike";
	var DrawTypeLiquid = "liquid";
	var DrawTypeFlowingLiquid = "flowingliquid";
	var DrawTypeGlassLike = "glasslike";
	var DrawTypeGlassLikeFramed = "glasslike_framed";
	var DrawTypeGlassLikeFramedOptional = "glasslike_framed_optional ";
	var DrawTypeAllFaces = "allfaces";
	var DrawTypeAllFacesOptional = "allfaces_optional";
	var DrawTypeTorchLike = "torchlike";
	var DrawTypeSignLike = "signlike";
	var DrawTypePlantLike = "plantlike";
	var DrawTypeFireLike = "firelike";
	var DrawTypeFenceLike = "fencelike";
	var DrawTypeRailLike = "raillike";
	var DrawTypeNodeBox = "nodebox";
	var DrawTypeMesh = "mesh";
	var DrawTypePlantLikeRooted = "plantlike_rooted";
}
