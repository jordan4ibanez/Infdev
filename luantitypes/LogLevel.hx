package luantitypes;

enum abstract LogLevel(String) to String {
	var none;
	var error;
	var warning;
	var action;
	var info;
	var verbose;
}
