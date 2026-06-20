package engine.definition;

private enum abstract NodeBoxType(String) to String {
	var NodeBoxTyperegular = "regular";
	var NodeBoxTypefixed = "fixed";
	var NodeBoxTypeleveled = "leveled";
	var NodeBoxTypewallmounted = "wallmounted";
	var NodeBoxTypeconnected = "connected";
}

class NodeBox {}
