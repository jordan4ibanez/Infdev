package engine.definition.basic;

enum abstract DrawType(String) to String {
	var DrawTypenormal = "normal";
	var DrawTypeairlike = "airlike";
	var DrawTypeliquid = "liquid";
	var DrawTypeflowingliquid = "flowingliquid";
	var DrawTypeglasslike = "glasslike";
	var DrawTypeglasslike_framed = "glasslike_framed";
	var DrawTypeglasslike_framed_optional = "glasslike_framed_optional ";
	var DrawTypeallfaces = "allfaces";
	var DrawTypeallfaces_optional = "allfaces_optional";
	var DrawTypetorchlike = "torchlike";
	var DrawTypesignlike = "signlike";
	var DrawTypeplantlike = "plantlike";
	var DrawTypefirelike = "firelike";
	var DrawTypefencelike = "fencelike";
	var DrawTyperaillike = "raillike";
	var DrawTypenodebox = "nodebox";
	var DrawTypemesh = "mesh";
	var DrawTypeplantlike_rooted = "plantlike_rooted";
}
