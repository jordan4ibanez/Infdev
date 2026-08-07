package src.game.entity.player;

final class PlayerAnimationHandler {
	// ? Animation stuff.
	var mining: Bool;
	var wasMining: Bool;
	var placing: Bool;
	var wasPlacing: Bool;
	var walking: Bool;
	var wasWalking: Bool;
	var sneaking: Bool;
	var wasSneaking: Bool;
	var animationTimer: Float = 0.0;
	// Stop looking at my hackjob.
	var animationPriority = -2_147_483_648;
	var oldLookPitch = 0.0;

	public function new() {}

	function playAnimation(animation: PlayerAnimation, ?speed: Float, ?loop: Bool = true): Void {
		this.object.playAnimation(animation, {
			priority: animationPriority,
			speed: speed,
			start_frame: animationTimer,
			blend: 0.15,
			loop: loop
		});

		animationPriority++;
	}

	inline function stopAnimation(animation: PlayerAnimation): Void {
		this.object.stopAnimation(animation);
	}

	inline function setAnimationSpeed(animation: PlayerAnimation, speed: Float): Void {
		this.object.updateAnimation(animation, {speed: speed});
	}
}
