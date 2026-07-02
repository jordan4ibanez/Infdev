package src.engine.entity.definition;

enum abstract EntityVisual(String) to String {
	var EntityVisualCube = "cube";
	var EntityVisualSprite = "sprite";
	var EntityVisualUpright_sprite = "upright_sprite";
	var EntityVisualMesh = "mesh";
	var EntityVisualWielditem = "wielditem";
	var EntityVisualItem = "item";
	var EntityVisualNode = "node";
}
