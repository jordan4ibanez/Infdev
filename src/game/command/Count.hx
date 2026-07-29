package src.game.command;

import src.engine.Core;
import src.engine.command.ChatCommand;
import src.engine.compilercode.LuaMap;

@:register("count")
final class Count implements ChatCommand {
	public var params: String;
	public var description: String = "Count for fun!";
	public var privs: LuaMap<String, Bool> = [
		"server" => true
	];

	var counter = new Map<String, Int>();

	public function func(name: String, param: String): CommandStatus {
		if (!counter.exists(name)) {
			counter.set(name, 1);
		} else {
			var count = counter.get(name);
			count++;
			counter.set(name, count);
		}

		var count = counter.get(name);

		Core.chatSendPlayer(name, 'You have counted to: $count');

		return new CommandStatus(true);
	}
}
