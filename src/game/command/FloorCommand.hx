package src.game.command;

import src.engine.Core;
import src.engine.command.ChatCommand;
import src.engine.compilercode.LuaMap;

@:register("floor")
final class FloorCommand implements ChatCommand {
	public var params: String;
	public var description: String;
	public var privs: LuaMap<String, Bool> = [
		"server" => true
	];

	public function func(name: String, param: String): CommandStatus {
		var player = Core.getPlayerByName(name);
		if (player == null) {
			return new CommandStatus(true);
		}

		return new CommandStatus(true);
	}
}
