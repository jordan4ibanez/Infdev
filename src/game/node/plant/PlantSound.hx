package src.game.node.plant;

import src.engine.definition.sound.NodeSoundTable;
import src.engine.definition.sound.SimpleSoundSpecTable;

@:final
abstract class PlantSound {
	public static function get(): NodeSoundTable {
		return new NodeSoundTable()
			.setDig(new SimpleSoundSpecTable("plant_mine")
				.setPitch(1.0)
				.setGain(0.5))
			.setDug(new SimpleSoundSpecTable("dirt_mine")
				.setPitch(1.1)
				.setGain(0.5))
			.setFootstep(new SimpleSoundSpecTable("plant_mine")
				.setGain(0.4)
				.setPitch(0.9))
			.setPlace(new SimpleSoundSpecTable("plant_mine")
				.setPitch(1.0))
			.setPlaceFailed(new SimpleSoundSpecTable("plant_mine")
				.setPitch(0.4));
	}
}
