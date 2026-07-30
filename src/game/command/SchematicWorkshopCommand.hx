package src.game.command;

import lua.Lua;
import src.engine.Core;
import src.engine.command.ChatCommand;
import src.engine.compilercode.LuaMap;
import src.engine.vector.Vec3;

@:register("schematic_workshop")
final class SchematicWorkshopCommand implements ChatCommand {
	public var params: String = "";
	public var description: String = "";
	public var privs: LuaMap<String, Bool>;

	public function func(name: String, args: String): CommandStatus {
		var player = Core.getPlayerByName(name);
		if (player == null) {
			return new CommandStatus(true);
		}

		var pos = player.getPos();

		return new CommandStatus(true);
	}
}
