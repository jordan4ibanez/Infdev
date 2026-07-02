package src.engine.entity.definition;

enum abstract EntityVisual(String) to String {
	var EntityVisualCube = "cube";
	var EntityVisualSprite = "sprite";
	var EntityVisualUprightSprite = "upright_sprite";
	var EntityVisualMesh = "mesh";
	var EntityVisualWieldItem = "wielditem";
	var EntityVisualItem = "item";
	var EntityVisualNode = "node";
}
