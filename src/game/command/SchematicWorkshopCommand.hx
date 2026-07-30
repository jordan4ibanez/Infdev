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

		// Parse the command input.
		var sizeOfEditor = new Vec3();
		{
			var argArray = args.split(" ");

			if (argArray.length != 3) {
				return new CommandStatus(false);
			}

			var x = Lua.tonumber(argArray[0]);
			var y = Lua.tonumber(argArray[1]);
			var z = Lua.tonumber(argArray[2]);

			if (x == null || y == null || z == null) {
				return new CommandStatus(false);
			}

			sizeOfEditor.setFloats(x, y, z);

			Core.chatSendPlayer(name, 'Creating new Schematic Editor with size [ $x $y $z ]');
		}

		var pos = player.getPos();

		return new CommandStatus(true);
	}
}
