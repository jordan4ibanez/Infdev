package engine.definition.basic;

enum abstract DrawType(String) to String {
	var normal = "normal";
	var airlike = "airlike";
	var liquid = "liquid";
	var flowingliquid = "flowingliquid";
	var glasslike = "glasslike";
	var glasslike_framed = "glasslike_framed";
	var glasslike_framed_optional = "glasslike_framed_optional ";
	var allfaces = "allfaces";
	var allfaces_optional = "allfaces_optional";
	var torchlike = "torchlike";
	var signlike = "signlike";

	var plantlike = "plantlike";
	var firelike = "firelike";
	var fencelike = "fencelike";
	var raillike = "raillike";
	var nodebox = "nodebox";
	var mesh = "mesh";
	var plantlike_rooted = "plantlike_rooted";
}
