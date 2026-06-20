package engine.definition.images;

enum abstract TileAnimationType(String) to String {
	var TileAnimationTypeVerticalFrames = "vertical_frames";
	var TileAnimationTypeSheet2d = "sheet_2d";
}

// todo: getters

@:noCompletion
interface TileAnimationDefinition {
	private var type: TileAnimationType;
}

final class TileAnimationDefinitionVerticalFrames implements TileAnimationDefinition {
	var type: TileAnimationType = TileAnimationTypeVerticalFrames;
	@:native("aspect_w")
	var aspectW: Int;
	@:native("aspect_h")
	var aspectH: Int;
	var length: Float;

	public function new(aspectW: Int, aspectH: Int, length: Float) {
		this.aspectW = aspectW;
		this.aspectH = aspectH;
		this.length = length;
	}
}

final class TileAnimationDefinitionSheet2d implements TileAnimationDefinition {
	var type: TileAnimationType = TileAnimationTypeSheet2d;
	@:native("frames_w")
	var framesW: Int;
	@:native("frames_h")
	var framesH: Int;
	@:native("frame_length")
	var frameLength: Float;

	public function new(framesW: Int, framesH: Int, frameLength: Float) {
		this.framesW = framesW;
		this.framesH = framesH;
		this.frameLength = frameLength;
	}
}
