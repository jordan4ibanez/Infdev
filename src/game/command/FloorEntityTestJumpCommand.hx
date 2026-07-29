package src.game.command;

import src.engine.Core;
import src.engine.command.ChatCommand;
import src.engine.compilercode.LuaMap;
import src.engine.vector.Vec3;

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

		var pos = player.getPos();

		for (x in -100...101) {
			for (z in -100...101) {
				Core.setNode(new Vec3(x, 0, z).add(pos), {name: "infdev:cobblestone"});
				Core.setNode(new Vec3(x, 1, z).add(pos), {name: "infdev:cobblestone"});
			}
		}

		return new CommandStatus(true);
	}
}
