package src.game.node.dirt;

import src.engine.definition.sound.NodeSoundTable;
import src.engine.definition.sound.SimpleSoundSpecTable;

@:final
abstract class DirtSound {
	public static function get(): NodeSoundTable {
		return new NodeSoundTable()
			.setDig(new SimpleSoundSpecTable("stone_mine")
				.setPitch(0.9))
			.setDug(new SimpleSoundSpecTable("stone_mine")
				.setPitch(0.75))
			.setFootstep(new SimpleSoundSpecTable("stone_step")
				.setPitch(0.8))
			.setPlace(new SimpleSoundSpecTable("stone_mine")
				.setPitch(0.65))
			.setPlaceFailed(new SimpleSoundSpecTable("stone_mine")
				.setPitch(0.4));
	}
}
