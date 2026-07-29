package src.game.command;

import src.engine.command.ChatCommand;
import src.engine.compilercode.LuaMap;

@:register("count")
final class Count implements ChatCommand {
	public var params: String = "";
	public var description: String = "Count for fun!";
	public var privs: LuaMap<String, Bool> = [
		"server" => true
	];

	var counter = new Map<String, Int>();

	public function func(name: String, param: String): CommandStatus {
		trace(this.counter);
		return new CommandStatus(true);
	}
}
