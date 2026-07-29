package src.engine.command;

import src.engine.compilercode.LuaMap;

final class CommandStatus {
	// If false and missing the output, it automatically throws a help message in the engine.
	public var success: Bool;
	public var output: String;

	public function new(success: Bool, ?output: String) {
		this.success = success;
		this.output = output;
	}
}

@:autoBuild(src.engine.compilercode.ChatCommandDuctTape.build())
interface ChatCommand {
	var params: String;
	var description: String;
	var privs: LuaMap<String, Bool>;
	function func(name: String, param: String): CommandStatus;
}
