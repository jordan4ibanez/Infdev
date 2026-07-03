package src.engine.entity.definition;

enum abstract StepUpMode(String) to String {
	var StepUpModeLegacy = "legacy";
	var StepUpModeFloaty = "floaty";
	var StepUpModeRigid = "rigid";
}
