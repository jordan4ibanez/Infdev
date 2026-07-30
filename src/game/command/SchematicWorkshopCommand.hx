package src.game.command;

import lua.Lua;
import src.engine.Core;
import src.engine.command.ChatCommand;
import src.engine.compilercode.LuaMap;
import src.engine.vector.Vec3;

@:register("s")
final class SchematicWorkshopCommand implements ChatCommand {
	public var params: String = "<x> <y> <z>";
	public var description: String = "Specialized development tool for creating schematics. The size should be odd on all axis. It will be promoted if not.";
	public var privs: LuaMap<String, Bool> = [
		"server" => true
	];

	// This could be an npm package one day.
	function isEven(input: Float): Bool {
		return input % 2 == 0;
	}

	public function func(name: String, args: String): CommandStatus {
		var player = Core.getPlayerByName(name);
		if (player == null) {
			return new CommandStatus(true);
		}

		// Parse the command input.
		var size = new Vec3();
		{
			var argArray = args.split(" ");

			if (argArray.length != 3) {
				return new CommandStatus(false);
			}

			var x = Lua.tonumber(argArray[0]);
			var y = Lua.tonumber(argArray[1]);
			var z = Lua.tonumber(argArray[2]);

			if (x == null || y == null || z == null || x <= 0 || y <= 0 || z <= 0) {
				return new CommandStatus(false);
			}

			if (isEven(x)) {
				x++;
				Core.chatSendPlayer(name, 'Size X promoted to $x');
			}
			if (isEven(y)) {
				y++;
				Core.chatSendPlayer(name, 'Size Y promoted to $y');
			}
			if (isEven(z)) {
				z++;
				Core.chatSendPlayer(name, 'Size Z promoted to $z');
			}

			// Set it to be centered and have the bedrock be the outer edge.
			size.setFloats(
				lua.Math.floor(x / 2) + 1,
				y + 1,
				lua.Math.floor(z / 2) + 1
			);

			Core.chatSendPlayer(name, 'Creating new Schematic Editor with size [ $x $y $z ]');
		}

		var pos = player.getPos();

		// Under the admin.
		pos.y -= 1;

		for (x in Std.int(-size.x)...Std.int(size.x + 1)) {
			for (z in Std.int(-size.z)...Std.int(size.z + 1)) {
				for (y in 0...Std.int(size.y + 1)) {
					Core.removeNode(pos.add(new Vec3(x, y, z)));

					var edgeX = (x == size.x || x == -size.x);
					var edgeY = (y == 0 || y == size.y);
					var edgeZ = (z == size.z || z == -size.z);
					if ((edgeX && edgeY) || (edgeX && edgeZ) || (edgeY && edgeZ) || (y == 0)) {
						Core.setNode(pos.add(new Vec3(x, y, z)), {name: "infdev:bedrock"});
					}
				}
			}
		}

		Core.setNode(pos, {name: "infdev:bedrock"});

		return new CommandStatus(true);
	}
}
