package src.game.command;

import lua.Lua;
import src.engine.Core;
import src.engine.command.ChatCommand;
import src.engine.compilercode.LuaMap;
import src.engine.vector.Vec3;

@:register("s")
final class SchematicWorkshopCommand implements ChatCommand {
	public var params: String = "<x> <y> <z>";
	public var description: String = "Specialized development tool for creating schematics.";
	public var privs: LuaMap<String, Bool> = [
		"server" => true
	];

	public function func(name: String, args: String): CommandStatus {
		var player = Core.getPlayerByName(name);
		if (player == null) {
			return new CommandStatus(true);
		}

		var pos = player.getPos();

		return new CommandStatus(true);
	}
}
