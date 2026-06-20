package luantitypes;

enum abstract LogLevel(String) to String {
	var LogLevelNone = "none";
	var LogLevelError = "error";
	var LogLevelWarning = "warning";
	var LogLevelAction = "action";
	var LogLevelInfo = "info";
	var LogLevelVerbose = "verbose";
}
