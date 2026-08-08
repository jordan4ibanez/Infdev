package src.game.command;

import lua.Lua;
import src.engine.Core;
import src.engine.Serialize;
import src.engine.command.ChatCommand;
import src.engine.compilercode.LuaMap;
import src.engine.vector.Vec3;
import src.game.node.specialty.SchematicWorkshopControlUnit;

@:register("s")
final class SchematicWorkshopCommand implements ChatCommand {
	public var params: String = "<x or schematic name> <y> <z>";
	public var description: String = "Schematic Workshop. Specialized development tool for creating schematics. The size should be odd on x and z axis. It will be promoted if not. Will load a schematic if given name.";
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
		var fullSize = new Vec3();
		var halfSize = new Vec3();
		{
			var argArray = StringTools.trim(args).split(" ");

			if (argArray.length != 3) {
				var loadingSchematicName = "test";

				if (argArray.length == 1) {
					if (argArray[0] != "") {
						loadingSchematicName = argArray[0];
					}
				} else {
					return new CommandStatus(false);
				}

				var success: Bool = untyped __lua__("core.place_schematic({0}, {1}, {2}, {3}, {4}, {5})", player.getPos(), Core.getWorldPath()
					+ "/"
					+ loadingSchematicName
					+ ".mts", "0", null, false, "place_center_x, place_center_z");

				if (!success) {
					return new CommandStatus(true, 'Schematic ${loadingSchematicName}.mts doesn\'t exist.');
				}

				return new CommandStatus(true, 'Loaded up ${loadingSchematicName}.mts from the world folder.');
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
			if (isEven(z)) {
				z++;
				Core.chatSendPlayer(name, 'Size Z promoted to $z');
			}

			// Set the real size.
			fullSize.setFloats(x, y, z);

			// Set it to be centered and have the bedrock be the outer edge.
			halfSize.setFloats(
				lua.Math.floor(x / 2) + 1,
				y + 1,
				lua.Math.floor(z / 2) + 1
			);

			Core.chatSendPlayer(name, 'Creating new Schematic Editor with size [ $x $y $z ]');
		}

		var pos = player.getPos();

		// Under the admin.
		pos.y -= 1;

		for (x in Std.int(-halfSize.x)...Std.int(halfSize.x + 1)) {
			for (z in Std.int(-halfSize.z)...Std.int(halfSize.z + 1)) {
				for (y in 0...Std.int(halfSize.y + 1)) {
					Core.removeNode(pos.add(new Vec3(x, y, z)));

					var edgeX = (x == halfSize.x || x == -halfSize.x);
					var edgeY = (y == 0 || y == halfSize.y);
					var edgeZ = (z == halfSize.z || z == -halfSize.z);

					if ((edgeX && edgeY) || (edgeX && edgeZ) || (edgeY && edgeZ) || (y == 0)) {
						Core.setNode(pos.add(new Vec3(x, y, z)), {name: "infdev:schematic_workshop_frame"});
					} else if (edgeX || edgeY || edgeZ) {
						Core.setNode(pos.add(new Vec3(x, y, z)), {name: "infdev:schematic_workshop_barrier"});
					}
				}
			}
		}

		// Put this in a negative position so it can do a simpler math to save schematic.
		final controllerPos = pos.add(new Vec3(-halfSize.x, 0, -halfSize.z));
		Core.setNode(controllerPos, {name: "infdev:schematic_workshop_control_unit"});
		var meta = Core.getMeta(controllerPos);
		meta.setString(SchematicWorkshopControlUnit.schematicSizeTag, Serialize.serialize(fullSize));
		// This stops a bug where onRightClick doesn't work on the first click even with a reclick.
		// todo: this was running vvv
		// meta.setString("formspec", SchematicWorkshopControlUnit.formspec.serialize(player));

		return new CommandStatus(true);
	}
}
