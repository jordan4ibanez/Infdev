package definition;

import haxe.extern.EitherType;

typedef TileAnimation = {
	var type: String;
	var ?frames: Int;
	var ?framerate: Float;
}

enum abstract TileAnimationType(String) to String {
	var verticalFrames = "vertical_frames";
	var sheet2d = "sheet_2d";
}

typedef ImageDefinitionTable = {
	var name: String;
	var ?animation: TileAnimation;
}

@:forward
abstract ItemImage(EitherType<String, ImageDefinitionTable>) from EitherType<String, ImageDefinitionTable> to EitherType<String, ImageDefinitionTable> {
	@:from
	public static inline function fromString(str: String): ItemImage {
		return cast str;
	}

	@:from
	public static inline function fromTable(struct: ImageDefinitionTable): ItemImage {
		return cast struct;
	}
}
