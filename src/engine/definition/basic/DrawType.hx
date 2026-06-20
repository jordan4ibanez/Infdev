package engine.definition.basic;

enum abstract DrawType(String) to String {
	var DrawTypeNormal = "normal";
	var DrawTypeAirlike = "airlike";
	var DrawTypeLiquid = "liquid";
	var DrawTypeFlowingliquid = "flowingliquid";
	var DrawTypeGlasslike = "glasslike";
	var DrawTypeGlasslike_framed = "glasslike_framed";
	var DrawTypeGlasslike_framed_optional = "glasslike_framed_optional ";
	var DrawTypeAllfaces = "allfaces";
	var DrawTypeAllfaces_optional = "allfaces_optional";
	var DrawTypeTorchlike = "torchlike";
	var DrawTypeSignlike = "signlike";
	var DrawTypePlantlike = "plantlike";
	var DrawTypeFirelike = "firelike";
	var DrawTypeFencelike = "fencelike";
	var DrawTypeRaillike = "raillike";
	var DrawTypeNodebox = "nodebox";
	var DrawTypeMesh = "mesh";
	var DrawTypePlantlike_rooted = "plantlike_rooted";
}
