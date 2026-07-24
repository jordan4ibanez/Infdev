package src.game.node.wood;

import src.engine.definition.sound.NodeSoundTable;
import src.engine.definition.sound.SimpleSoundSpecTable;

@:final
abstract class WoodSound {
	public static function get(): NodeSoundTable {
		return new NodeSoundTable()
			.setDig(new SimpleSoundSpecTable("wood_mine")
				.setPitch(0.9))
			.setDug(new SimpleSoundSpecTable("wood_mine")
				.setPitch(0.75))
			.setFootstep(new SimpleSoundSpecTable("wood_step")
				.setPitch(0.8))
			.setPlace(new SimpleSoundSpecTable("wood_mine")
				.setPitch(0.65))
			.setPlaceFailed(new SimpleSoundSpecTable("wood_mine")
				.setPitch(0.4));
	}
}
