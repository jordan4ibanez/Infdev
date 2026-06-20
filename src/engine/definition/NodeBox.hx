package engine.definition;

private enum abstract NodeBoxType(String) to String {
	var regular = "regular";
	var fixed = "fixed";
	var leveled = "leveled";
	var wallmounted = "wallmounted";
	var connected = "connected";
}

class NodeBox {}
