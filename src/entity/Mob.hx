package entity;

class Mob extends Entity {
	override function onActivate(staticData: String, dtimeS: Float) {
		super.onActivate(staticData, dtimeS);
		trace(staticData);
	}

	override function onStep(delta: Float) {
		super.onStep(delta);
	}

	override function getStaticData(): String {
		return "test 1234";
	}
}
