package src.game.node.glass;

import src.engine.definition.sound.NodeSoundTable;
import src.engine.definition.sound.SimpleSoundSpecTable;

@:final
abstract class PlantSound {
	public static function get(): NodeSoundTable {
		return new NodeSoundTable()
			.setDig(new SimpleSoundSpecTable("glass_mine")
				.setPitch(0.9))
			.setDug(new SimpleSoundSpecTable("glass_mine")
				.setPitch(0.75))
			.setFootstep(new SimpleSoundSpecTable("glass_step")
				.setPitch(0.8))
			.setPlace(new SimpleSoundSpecTable("glass_mine")
				.setPitch(0.65))
			.setPlaceFailed(new SimpleSoundSpecTable("glass_mine")
				.setPitch(0.4));
	}
}
