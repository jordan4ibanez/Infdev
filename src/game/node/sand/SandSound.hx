package src.game.node.sand;

import src.engine.definition.sound.NodeSoundTable;
import src.engine.definition.sound.SimpleSoundSpecTable;

@:final
abstract class SandSound {
	public static function get(): NodeSoundTable {
		return new NodeSoundTable()
			.setDig(new SimpleSoundSpecTable("sand_mine")
				.setPitch(0.9)
				.setGain(2))
			.setDug(new SimpleSoundSpecTable("sand_mine")
				.setPitch(0.75)
				.setGain(2))
			.setFootstep(new SimpleSoundSpecTable("sand_mine")
				.setPitch(0.8)
				.setGain(1))
			.setPlace(new SimpleSoundSpecTable("sand_mine")
				.setPitch(0.65)
				.setGain(2))
			.setPlaceFailed(new SimpleSoundSpecTable("sand_mine")
				.setPitch(0.4)
				.setGain(2));
	}
}
